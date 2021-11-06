%packages

# Exclude unwanted groups that nobara-live-base.ks pulls in
-@dial-up
-@input-methods
-@standard

# Nobara repos
nobara-repos
fedora-repos

# Make sure to sync any additions / removals done here with
# workstation-product-environment in comps
@base-x
@core
@firefox
@fonts
@gnome-desktop
@guest-desktop-agents
@hardware-support
@libreoffice
@multimedia
@networkmanager-submodules
@printing
@workstation-product

# gaming related packages
steam
lutris

# WINE dependencies
alsa-plugins-pulseaudio.i686
glibc-devel.i686
glibc-devel
libgcc.i686
libX11-devel.i686
freetype-devel.i686
libXcursor-devel.i686
libXi-devel.i686
libXext-devel.i686
libXxf86vm-devel.i686
libXrandr-devel.i686
libXinerama-devel.i686
mesa-libGLU-devel.i686
mesa-libOSMesa-devel.i686
libXrender-devel.i686
libpcap-devel.i686
ncurses-devel.i686
libzip-devel.i686
lcms2-devel.i686
zlib-devel.i686
libv4l-devel.i686
libgphoto2-devel.i686
cups-devel.i686
libxml2-devel.i686
openldap-devel.i686
libxslt-devel.i686
gnutls-devel.i686
libpng-devel.i686
flac-libs.i686
json-c.i686
libICE.i686
libSM.i686
libXtst.i686
libasyncns.i686
liberation-narrow-fonts.noarch
libieee1284.i686
libogg.i686
libsndfile.i686
libuuid.i686
libva.i686
libvorbis.i686
libwayland-client.i686
libwayland-server.i686
llvm-libs.i686
mesa-dri-drivers.i686
mesa-filesystem.i686
mesa-libEGL.i686
mesa-libgbm.i686
nss-mdns.i686
ocl-icd.i686
pulseaudio-libs.i686
sane-backends-libs.i686
tcp_wrappers-libs.i686
unixODBC.i686
samba-common-tools.x86_64
samba-libs.x86_64
samba-winbind.x86_64
samba-winbind-clients.x86_64
samba-winbind-modules.x86_64
mesa-libGL-devel.i686
fontconfig-devel.i686
libXcomposite-devel.i686
libtiff-devel.i686
openal-soft-devel.i686
mesa-libOpenCL-devel.i686
opencl-utils-devel.i686
alsa-lib-devel.i686
gsm-devel.i686
libjpeg-turbo-devel.i686
pulseaudio-libs-devel.i686
pulseaudio-libs-devel
gtk3-devel.i686
libattr-devel.i686
libva-devel.i686
libexif-devel.i686
libexif.i686
glib2-devel.i686
mpg123-devel.i686
mpg123-devel.x86_64
libcom_err-devel.i686
libcom_err-devel.x86_64
libFAudio-devel.i686
libFAudio-devel.x86_64
gstreamer1.x86_64
gstreamer1-plugins-base.x86_64
gstreamer1-plugins-good.x86_64
gstreamer1-plugins-bad-free.x86_64
gstreamer1-plugins-bad-freeworld.x86_64
gstreamer1-plugins-ugly.x86_64
gstreamer1-plugins-ugly-free.x86_64
gstreamer1-libav.x86_64
gstreamer1.i686
gstreamer1-plugins-base.i686
gstreamer1-plugins-good.i686
gstreamer1-plugins-bad-free.i686
gstreamer1-plugins-bad-freeworld.i686
gstreamer1-plugins-ugly.i686
gstreamer1-plugins-ugly-free.i686
gstreamer1-libav.i686
wine
winetricks

# mangohud/goverlay
goverlay
mangohud
mangohud.i686

# obs for streaming
obs-studio

# kdenlive for video editing
kdenlive

# exclude this, it breaks wine prefix creation
-gst-editing-services
-rygel

# Exclude unwanted packages from @anaconda-tools group
-gfs2-utils
-reiserfs-utils

%end
