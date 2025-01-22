$ErrorActionPreference = "Stop"

$SCRIPT_DIR = $PSScriptRoot
$BASEDIR = Resolve-Path "$SCRIPT_DIR\.."

$CONFIG = Join-Path -Path $BASEDIR -ChildPath "etc/install.win.yml"

$DOTBOT_DIR = Join-Path -Path $BASEDIR -ChildPath "ext/dotbot"
$DOTBOT_BIN = Join-Path -Path $DOTBOT_DIR -ChildPath "bin/dotbot"

$originalLocation = Get-Location
try {
    Set-Location $DOTBOT_DIR

    git submodule update --init --recursive
    foreach ($PYTHON in ('python', 'python3')) {
        # Python redirects to Microsoft Store in Windows 10 when not installed
        if (& { $ErrorActionPreference = "SilentlyContinue"
                ![string]::IsNullOrEmpty((&$PYTHON -V))
                $ErrorActionPreference = "Stop" }) {
            &$PYTHON $DOTBOT_BIN -d $BASEDIR -c $CONFIG $Args
            return
        }
    }
    Write-Error "Error: Cannot find Python."
} finally {
    Set-Location $originalLocation
}