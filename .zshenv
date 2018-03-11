
XKB_DEFAULT_LAYOUT=se
XKB_DEFAULT_OPTIONS=compose:ralt,caps:nocaps
# XKB_DEFAULT_VARIANT=nodeadkeys

GTK_THEME=Adapta

# GTK+ (3.0+)
GDK_BACKEND=wayland
CLUTTER_BACKEND=wayland

# QT5
QT_QPA_PLATFORM=wayland-egl
QT_WAYLAND_DISABLE_WINDOWDECORATION=1

# Elementary/EFL
ECORE_EVAS_ENGINE=wayland_egl	# wayland_shm for sw render
ELM_ENGINE=wayland_egl 		# wayland_shm for sw render

# SDL
SDL_VIDEODRIVER=wayland

# Java (Wayland fix)
_JAVA_AWT_WM_NONREPARENTING=1

