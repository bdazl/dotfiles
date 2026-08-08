# Raspberry Pi

Tools for building a bootable Arch Linux ARM SD card:

* [pi-flash](pi-flash): partition and flash an SD card, install dotfiles, enable SSH
* [pi-arch](pi-arch): install packages; runs on the Pi itself, or in a chroot via `pi-flash --packages`

## Flashing an SD card

Find the SD card device with `lsblk`, then:

```sh
sudo bin/install/pi-flash /dev/sdX --user jacob --ssh-key ~/.ssh/id_ed25519.pub --hostname mypi
```

The host must have the Arch Linux ARM signing keyring installed:

```sh
yay -S archlinuxarm-keyring
```

This downloads the Arch Linux ARM image over HTTPS, verifies its official GPG
signature, caches it in `/var/cache/pi-flash`, and partitions the card
(FAT32 boot + ext4 root), extracts the image, creates the user with passwordless
sudo, copies this repo to `~/etc` for both root and the user, and enables sshd.
Dotbot runs via a one-shot systemd service on first boot. Password authentication
is disabled for both root and the named user, so at least one valid `--ssh-key`
is required.

Select the Raspberry Pi model with `--model {2,3,4,5}` (default: 5):

| Model | Image | Notes |
|-------|-------|-------|
| 5 | AArch64 | boot partition rebuilt with the foundation kernel (`linux-rpi-16k`); U-Boot does not support the Pi 5 |
| 4 | AArch64 | fstab adjusted, the SD card appears as `mmcblk1` |
| 3 | AArch64 | stock image |
| 2 | ARMv7 | stock image |

Useful flags:

* `--packages`: pre-install all `pi-arch` packages via `arch-chroot` + QEMU emulation
  (requires `qemu-user-static-binfmt` and `arch-install-scripts` on the host); slower
  to flash but the Pi is fully provisioned on first boot. Without it, the pacman
  keyring is initialized on first boot instead, and `pi-arch` is run manually on the Pi.
* `--reuse`: keep the existing partitions and root filesystem instead of
  repartitioning
* `--tarball <path>`: use a pre-downloaded image tarball; its detached signature
  must be available at `<path>.sig`
* `--keyring <path>`: use another Arch Linux ARM GPG keyring

The card is repartitioned and formatted by default, and the confirmation prompt
asks for the device name (`sde`) rather than a bare `y`.

The flash process is resumable — completed steps are tracked on the card and
skipped when re-run after a failure. Since the default reformats the card, resume
state only survives under `--reuse`, which is how an interrupted flash is picked
back up. Resume requires the same model, user, hostname, shell, SSH keys, package
mode, and dotfiles mode; drop `--reuse` when changing any of these options.

For `--model 5` without `--packages`, the kernel is installed by file extraction
outside pacman. After first boot, adopt it into pacman and regenerate the initramfs:

```sh
sudo pacman -R --noconfirm linux-aarch64 uboot-raspberrypi
sudo pacman -Syu --overwrite '/boot/*' --noconfirm linux-rpi-16k
```

(with `--packages` this is already done in the chroot.)

## Tests

The regression suite mocks all destructive system operations; it never mounts,
formats, or writes to a block device:

```sh
python -m unittest discover -s tests -v
```
