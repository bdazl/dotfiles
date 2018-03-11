typeset -U path
path=(/home/jacob/.local/bin $path[@])

export XKB_DEFAULT_LAYOUT=se
export XKB_DEFAULT_VARIANT=,nodeadkeys
export XKB_DEFAULT_MODEL=dell
export XKB_DEFAULT_OPTIONS=compose:ralt,caps:nocaps

export GTK_THEME=Adapta

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

