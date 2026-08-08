"""Regression tests for the Raspberry Pi flashing utility."""

# pylint: disable=missing-class-docstring,missing-function-docstring

from __future__ import annotations

import importlib.machinery
import importlib.util
import shutil
import subprocess
import sys
import tempfile
import unittest
from contextlib import contextmanager, redirect_stderr, redirect_stdout
from io import StringIO
from pathlib import Path
from types import ModuleType
from typing import Iterator
from unittest import mock


SCRIPT = Path(__file__).parents[1] / "bin/install/pi-flash"


def load_pi_flash() -> ModuleType:
    """Load the extensionless pi-flash script as a Python module."""
    loader = importlib.machinery.SourceFileLoader("pi_flash", str(SCRIPT))
    spec = importlib.util.spec_from_loader(loader.name, loader)
    if spec is None:
        raise RuntimeError("could not create module spec for pi-flash")
    module = importlib.util.module_from_spec(spec)
    sys.modules[loader.name] = module
    loader.exec_module(module)
    return module


pi_flash = load_pi_flash()


@contextmanager
def expected_exit(test_case: unittest.TestCase) -> Iterator[None]:
    """Capture diagnostics while asserting a deliberate command-line exit."""
    with (
        redirect_stdout(StringIO()),
        redirect_stderr(StringIO()),
        test_case.assertRaises(SystemExit),
    ):
        yield


class ConfigurationTests(unittest.TestCase):
    def test_user_step_is_a_separate_callable(self) -> None:
        self.assertTrue(callable(pi_flash.step_user))

    def test_resume_state_rejects_changed_configuration(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            context = {"model": "4", "user": "jacob"}
            pi_flash.save_state(root, {"extract"}, context)

            with expected_exit(self):
                pi_flash.load_state(root, {"model": "5", "user": "jacob"})

    def test_resume_state_round_trips_with_same_configuration(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            context = {"model": "5", "user": "jacob"}
            pi_flash.save_state(root, {"extract", "kernel"}, context)

            self.assertEqual(
                pi_flash.load_state(root, context),
                {"extract", "kernel"},
            )

    def test_identity_validation_rejects_config_injection(self) -> None:
        with expected_exit(self):
            pi_flash.validate_identity("bad\nuser", "paj", "/usr/bin/zsh")
        with expected_exit(self):
            pi_flash.validate_identity("jacob", "bad host", "/usr/bin/zsh")
        with expected_exit(self):
            pi_flash.validate_identity("jacob", "paj", "zsh; reboot")
        with expected_exit(self):
            pi_flash.validate_identity("jacob", "paj", "/bin/zsh:root")


class DeviceSafetyTests(unittest.TestCase):
    def test_preflight_validates_before_cleaning_stale_mount(self) -> None:
        events: list[str] = []

        with (
            mock.patch.object(
                pi_flash,
                "validate_device",
                side_effect=lambda device, force: events.append("validate") or device,
            ),
            mock.patch.object(
                pi_flash,
                "cleanup_stale_mount",
                side_effect=lambda device: events.append("cleanup"),
            ),
            mock.patch.object(
                pi_flash,
                "check_device_unmounted",
                side_effect=lambda device: events.append("mounted"),
            ),
        ):
            result = pi_flash.preflight_device("/dev/sdb", force=False)

        self.assertEqual(result, "/dev/sdb")
        self.assertEqual(events, ["validate", "cleanup", "mounted"])

    def test_destructive_confirmation_requires_the_device_name(self) -> None:
        for answer in ("y", "yes", "", "sdb1", "SDB"):
            with (
                mock.patch.object(pi_flash, "read_sysfs", return_value="1024"),
                mock.patch.object(pi_flash, "run"),
                mock.patch("builtins.input", return_value=answer),
                expected_exit(self),
            ):
                pi_flash.confirm_device("/dev/sdb")

    def test_destructive_confirmation_accepts_the_device_name(self) -> None:
        with (
            mock.patch.object(pi_flash, "read_sysfs", return_value="1024"),
            mock.patch.object(pi_flash, "run"),
            mock.patch("builtins.input", return_value=" sdb "),
            redirect_stdout(StringIO()),
        ):
            pi_flash.confirm_device("/dev/sdb")

    def test_regular_file_is_not_accepted_as_a_device(self) -> None:
        with tempfile.NamedTemporaryFile() as regular_file:
            with expected_exit(self):
                pi_flash.validate_device(regular_file.name, force=True)

    def test_mount_check_uses_compatible_raw_output(self) -> None:
        findmnt = subprocess.CompletedProcess(
            ["findmnt"], 0, stdout="8:1 /boot\n", stderr=""
        )
        with (
            mock.patch.object(pi_flash, "block_device_ids", return_value={"8:16"}),
            mock.patch.object(pi_flash.subprocess, "run", return_value=findmnt) as run,
        ):
            pi_flash.check_device_unmounted("/dev/sdb")

        run.assert_called_once_with(
            ["findmnt", "-rn", "-o", "MAJ:MIN,TARGET"],
            capture_output=True,
            text=True,
            check=True,
        )

    def test_mount_check_rejects_mounted_child_partition(self) -> None:
        findmnt = subprocess.CompletedProcess(
            ["findmnt"], 0, stdout="8:18 /run/media/card\n", stderr=""
        )
        with (
            mock.patch.object(
                pi_flash, "block_device_ids", return_value={"8:16", "8:18"}
            ),
            mock.patch.object(pi_flash.subprocess, "run", return_value=findmnt),
            expected_exit(self),
        ):
            pi_flash.check_device_unmounted("/dev/sdb")

    def test_stale_mount_from_another_device_is_not_unmounted(self) -> None:
        findmnt = subprocess.CompletedProcess(
            ["findmnt"], 0, stdout="8:2\n", stderr=""
        )
        with (
            mock.patch.object(Path, "is_mount", return_value=True),
            mock.patch.object(pi_flash, "block_device_ids", return_value={"8:16", "8:18"}),
            mock.patch.object(pi_flash.subprocess, "run", return_value=findmnt),
            mock.patch.object(pi_flash, "unmount") as unmount,
            expected_exit(self),
        ):
            pi_flash.cleanup_stale_mount("/dev/sdb")

        unmount.assert_not_called()


class DownloadTests(unittest.TestCase):
    def test_default_sources_use_https(self) -> None:
        self.assertTrue(pi_flash.ALARM_OS_URL.startswith("https://"))
        self.assertTrue(pi_flash.ALARM_MIRROR_CORE.startswith("https://"))
        self.assertEqual(pi_flash.CACHE_ROOT, Path("/var/cache/pi-flash"))

    def test_cached_tarball_is_still_signature_verified(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            cache_root = Path(directory)
            artifact = cache_root / "rootfs.tar.gz"
            signature = cache_root / "rootfs.tar.gz.sig"
            artifact.write_bytes(b"archive")
            signature.write_bytes(b"signature")

            with (
                mock.patch.object(pi_flash, "CACHE_ROOT", cache_root),
                mock.patch.object(pi_flash, "verify_signature") as verify,
                redirect_stdout(StringIO()),
            ):
                result = pi_flash.download_verified(
                    "https://example.invalid/rootfs.tar.gz",
                    Path("/keyring.gpg"),
                )

            self.assertEqual(result, artifact)
            verify.assert_called_once_with(artifact, signature, Path("/keyring.gpg"))

    def test_local_tarball_requires_a_signature(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            tarball = Path(directory) / "rootfs.tar.gz"
            tarball.write_bytes(b"archive")

            with expected_exit(self):
                pi_flash.download_tarball(
                    str(tarball),
                    "https://example.invalid/rootfs.tar.gz",
                    Path("/keyring.gpg"),
                )

    def test_signature_must_use_the_pinned_build_key(self) -> None:
        result = subprocess.CompletedProcess(
            ["gpgv"],
            0,
            stdout="[GNUPG:] VALIDSIG 0000000000000000000000000000000000000000\n",
            stderr="",
        )
        with tempfile.TemporaryDirectory() as directory:
            keyring = Path(directory) / "keyring.gpg"
            keyring.write_bytes(b"\x99binary-keyring")
            with (
                mock.patch.object(pi_flash.subprocess, "run", return_value=result),
                expected_exit(self),
            ):
                pi_flash.verify_signature(
                    Path("artifact"), Path("artifact.sig"), keyring
                )

    def test_ascii_armored_keyring_is_decoded_for_gpgv(self) -> None:
        dearmor = subprocess.CompletedProcess(["gpg"], 0, stdout="", stderr="")
        verified = subprocess.CompletedProcess(
            ["gpgv"],
            0,
            stdout=f"[GNUPG:] VALIDSIG {pi_flash.ALARM_SIGNING_KEY}\n",
            stderr="",
        )
        with tempfile.TemporaryDirectory() as directory:
            keyring = Path(directory) / "keyring.gpg"
            keyring.write_text(
                "-----BEGIN PGP PUBLIC KEY BLOCK-----\n\nkey\n"
                "-----END PGP PUBLIC KEY BLOCK-----\n"
            )
            with mock.patch.object(
                pi_flash.subprocess, "run", side_effect=[dearmor, verified]
            ) as run:
                pi_flash.verify_signature(
                    Path("artifact"), Path("artifact.sig"), keyring
                )

        dearmor_command = run.call_args_list[0].args[0]
        verify_command = run.call_args_list[1].args[0]
        self.assertEqual(
            dearmor_command[0:4],
            ["gpg", "--batch", "--no-options", "--dearmor"],
        )
        self.assertEqual(dearmor_command[-1], str(keyring))
        self.assertEqual(verify_command[0], "gpgv")
        self.assertNotEqual(verify_command[4], str(keyring))

    def test_kernel_package_selection_uses_version_order(self) -> None:
        packages = [
            "linux-rpi-16k-6.12.9-1-aarch64.pkg.tar.xz",
            "linux-rpi-16k-6.12.10-1-aarch64.pkg.tar.xz",
        ]

        def vercmp(left: str, right: str) -> int:
            left_parts = tuple(int(part) for part in left.split("-")[0].split("."))
            right_parts = tuple(int(part) for part in right.split("-")[0].split("."))
            return (left_parts > right_parts) - (left_parts < right_parts)

        self.assertEqual(
            pi_flash.latest_kernel_package("linux-rpi-16k", packages, vercmp),
            packages[1],
        )


class AuthenticationTests(unittest.TestCase):
    def test_parser_requires_an_ssh_key(self) -> None:
        parser = pi_flash.build_parser()
        with expected_exit(self):
            parser.parse_args(["/dev/sdb", "--user", "jacob"])

    def test_missing_ssh_key_fails_instead_of_warning(self) -> None:
        with expected_exit(self):
            pi_flash.validate_ssh_keys(["/does/not/exist.pub"])

    def test_malformed_existing_ssh_key_fails(self) -> None:
        invalid = subprocess.CompletedProcess(["ssh-keygen"], 255, "", "invalid")
        with tempfile.NamedTemporaryFile(mode="w", suffix=".pub") as key_file:
            key_file.write("not a public key\n")
            key_file.flush()
            with (
                mock.patch.object(pi_flash.subprocess, "run", return_value=invalid),
                expected_exit(self),
            ):
                pi_flash.validate_ssh_keys([key_file.name])


class ArchitectureTests(unittest.TestCase):
    def test_model_uses_matching_binfmt_handler(self) -> None:
        self.assertEqual(pi_flash.binfmt_handler("2"), "qemu-arm")
        self.assertEqual(pi_flash.binfmt_handler("5"), "qemu-aarch64")


class ProvisioningTests(unittest.TestCase):
    """The defects that produced a card nobody could log into."""

    def test_packages_are_installed_unless_opted_out(self) -> None:
        parser = pi_flash.build_parser()
        base = ["/dev/sdb", "--user", "jacob", "--ssh-key", "key.pub"]

        self.assertTrue(parser.parse_args(base).packages)
        self.assertFalse(parser.parse_args(base + ["--no-packages"]).packages)

    def test_skipping_dotfiles_also_skips_packages(self) -> None:
        parser = pi_flash.build_parser()
        args = parser.parse_args(
            ["/dev/sdb", "--user", "jacob", "--ssh-key", "key.pub", "--no-dotfiles"]
        )

        with redirect_stdout(StringIO()):
            pi_flash.apply_flag_implications(args)

        self.assertFalse(args.packages)

    def test_chroot_pacman_opts_out_of_the_landlock_sandbox(self) -> None:
        with (
            mock.patch.object(pi_flash, "run") as run,
            redirect_stdout(StringIO()),
        ):
            pi_flash.step_packages(Path("/mnt"), rpi_kernel="linux-rpi-16k")

        pacman_calls = [
            call.args[0] for call in run.call_args_list if "pacman" in call.args[0]
        ]
        self.assertTrue(pacman_calls)
        for command in pacman_calls:
            self.assertIn("--disable-sandbox", command)

    def test_missing_login_shell_falls_back_to_bash(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "etc").mkdir()
            (root / "bin").mkdir()
            (root / "bin/bash").touch()
            (root / "etc/passwd").write_text(
                "root:x:0:0::/root:/bin/bash\njacob:x:1000:1000::/home/jacob:/usr/bin/zsh\n",
                encoding="utf-8",
            )

            with redirect_stdout(StringIO()):
                pi_flash.step_verify_shell(root, "jacob")

            self.assertIn(
                "jacob:x:1000:1000::/home/jacob:/bin/bash",
                (root / "etc/passwd").read_text(encoding="utf-8"),
            )

    def test_present_login_shell_is_left_alone(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "etc").mkdir()
            (root / "usr/bin").mkdir(parents=True)
            (root / "usr/bin/zsh").touch()
            original = "jacob:x:1000:1000::/home/jacob:/usr/bin/zsh\n"
            (root / "etc/passwd").write_text(original, encoding="utf-8")

            with redirect_stdout(StringIO()):
                pi_flash.step_verify_shell(root, "jacob")

            self.assertEqual((root / "etc/passwd").read_text(encoding="utf-8"), original)

    def test_first_boot_installs_packages_before_running_dotbot(self) -> None:
        unit = self.render_first_boot(provision=True, dotfiles=True)
        commands = [
            line.removeprefix("ExecStart=")
            for line in unit.splitlines()
            if line.startswith("ExecStart=")
        ]

        self.assertEqual(commands[0], "/usr/bin/pacman-key --init")
        self.assertLess(
            commands.index("/root/etc/bin/install/pi-arch"),
            commands.index("/root/etc/install"),
        )
        self.assertIn("After=network-online.target", unit)

    def test_first_boot_skips_provisioning_done_in_the_chroot(self) -> None:
        unit = self.render_first_boot(provision=False, dotfiles=True)

        self.assertNotIn("pi-arch", unit)
        self.assertNotIn("pacman-key", unit)
        self.assertIn("ExecStart=/root/etc/install", unit)

    def test_reused_rootfs_is_reported_and_unstamped(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "etc").mkdir()
            (root / "etc/os-release").write_text("ID=archarm\n", encoding="utf-8")
            (root / "etc/machine-id").write_text("deadbeef\n", encoding="utf-8")

            output = StringIO()
            with redirect_stdout(output):
                pi_flash.warn_reused_rootfs(root)

            self.assertIn("NOT the downloaded tarball", output.getvalue())
            self.assertFalse((root / "etc/machine-id").exists())

    def render_first_boot(self, provision: bool, dotfiles: bool) -> str:
        """Write the first-boot unit into a throwaway root and return its text."""
        directory = tempfile.mkdtemp()
        self.addCleanup(shutil.rmtree, directory)
        root = Path(directory)

        with redirect_stdout(StringIO()):
            pi_flash.step_first_boot(root, "jacob", provision=provision, dotfiles=dotfiles)

        return (root / "etc/systemd/system" / pi_flash.FIRST_BOOT_SERVICE).read_text(
            encoding="utf-8"
        )


class MountLifecycleTests(unittest.TestCase):
    def test_partial_mount_is_cleaned_up(self) -> None:
        mount_error = subprocess.CalledProcessError(1, ["mount"])
        with tempfile.TemporaryDirectory() as directory:
            mount_root = Path(directory) / "mnt"
            with (
                mock.patch.object(pi_flash, "MOUNT_ROOT", mount_root),
                mock.patch.object(
                    pi_flash,
                    "run",
                    side_effect=[mock.DEFAULT, mount_error],
                ),
                mock.patch.object(pi_flash, "unmount") as unmount,
                redirect_stdout(StringIO()),
                self.assertRaises(subprocess.CalledProcessError),
            ):
                pi_flash.mount_partitions("/dev/sdb1", "/dev/sdb2")

            unmount.assert_called_once_with(mount_root, allow_lazy=True)

    def test_context_manager_cleans_up_keyboard_interrupt(self) -> None:
        with (
            mock.patch.object(
                pi_flash,
                "mount_partitions",
                return_value=(pi_flash.MOUNT_ROOT, pi_flash.MOUNT_ROOT / "boot"),
            ),
            mock.patch.object(pi_flash, "unmount") as unmount,
            self.assertRaises(KeyboardInterrupt),
        ):
            with pi_flash.mounted_partitions("/dev/sdb1", "/dev/sdb2"):
                raise KeyboardInterrupt

        unmount.assert_called_once_with(pi_flash.MOUNT_ROOT, allow_lazy=True)

    def test_successful_context_requires_clean_unmount(self) -> None:
        with (
            mock.patch.object(
                pi_flash,
                "mount_partitions",
                return_value=(pi_flash.MOUNT_ROOT, pi_flash.MOUNT_ROOT / "boot"),
            ),
            mock.patch.object(pi_flash, "unmount") as unmount,
        ):
            with pi_flash.mounted_partitions("/dev/sdb1", "/dev/sdb2"):
                pass

        unmount.assert_called_once_with(pi_flash.MOUNT_ROOT, allow_lazy=False)


if __name__ == "__main__":
    unittest.main()
