#!/bin/zsh
#
# Author: Jacob Peyron <jacob.peyron@gmail.com>
#
# Wayland specifics

function wayland_env()
{
    # GTK+ (3.0+)
    export GDK_BACKEND=wayland
    export CLUTTER_BACKEND=wayland

    # QT5
    export QT_QPA_PLATFORM=wayland-egl
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

    # Elementary/EFL
    export ECORE_EVAS_ENGINE=wayland_egl	# wayland_shm for sw render
    export ELM_ENGINE=wayland_egl 		# wayland_shm for sw render

    # SDL
    export SDL_VIDEODRIVER=wayland

    # Java (Wayland fix)
    export _JAVA_AWT_WM_NONREPARENTING=1
}

# Don't use this for now
# wayland_env
