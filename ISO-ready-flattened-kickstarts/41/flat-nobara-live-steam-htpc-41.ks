# Generated by pykickstart v3.52
#version=DEVEL
# Firewall configuration
firewall --enabled --service=mdns
# Keyboard layouts
keyboard 'us'
# System language
lang en_US.UTF-8
# Network information
network  --bootproto=dhcp --device=link --activate
# Shutdown after installation
shutdown
repo --name="fedora" --baseurl=https://nobara-fedora.nobaraproject.org/$releasever/ --cost=99
repo --name="fedora-updates" --baseurl=https://nobara-fedora-updates.nobaraproject.org/$releasever/ --cost=99
repo --name="nobara-baseos" --baseurl=https://download.copr.fedorainfracloud.org/results/gloriouseggroll/nobara-41/fedora-$releasever-$basearch/ --cost=1
repo --name="nobara-baseos-multilib" --baseurl=https://download.copr.fedorainfracloud.org/results/gloriouseggroll/nobara-41/fedora-$releasever-i386/ --cost=1
repo --name="nobara-appstream" --baseurl=https://nobara-appstream.nobaraproject.org/$releasever/$basearch --cost=1 --exclude=nobara-resolve-runtime,ffmpeg,ffmpeg-libs,libavcodec-freeworld,libavdevice,mesa-va-drivers-freeworld,mesa-vdpau-drivers-freeworld,mesa-libgallium-freeworld
# Root password
rootpw --iscrypted --lock locked
# SELinux configuration
selinux --disabled
# System services
services --disabled="sshd,custom-device-pollrates" --enabled="NetworkManager,ModemManager,akmods"
# System timezone
timezone US/Eastern
# Use network installation
url --mirrorlist="https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch"
# X Window System configuration information
xconfig  --startxonboot
# System bootloader configuration
bootloader --location=none
# Clear the Master Boot Record
zerombr
# Partition clearing information
clearpart --all
# Disk partitioning information
part / --fstype="ext4" --size=25600
part / --size=25600

%post
# Enable livesys services
systemctl enable livesys.service
systemctl enable livesys-late.service

# add static hostname
hostnamectl set-hostname "nobara-live"

# enable tmpfs for /tmp
systemctl enable tmp.mount

# make it so that we don't do writing to the overlay for things which
# are just tmpdirs/caches
# note https://bugzilla.redhat.com/show_bug.cgi?id=1135475
cat >> /etc/fstab << EOF
vartmp   /var/tmp    tmpfs   defaults   0  0
EOF

# work around for poor key import UI in PackageKit
rm -f /var/lib/rpm/__db*
echo "Packages within this LiveCD"
rpm -qa --qf '%{size}\t%{name}-%{version}-%{release}.%{arch}\n' |sort -rn
# Note that running rpm recreates the rpm db files which aren't needed or wanted
rm -f /var/lib/rpm/__db*

# go ahead and pre-make the man -k cache (#455968)
/usr/bin/mandb

# make sure there aren't core files lying around
rm -f /core*

# remove random seed, the newly installed instance should make it's own
rm -f /var/lib/systemd/random-seed

# convince readahead not to collect
# FIXME: for systemd

echo 'File created by kickstart. See systemd-update-done.service(8).' \
    | tee /etc/.updated >/var/.updated

# Drop the rescue kernel and initramfs, we don't need them on the live media itself.
# See bug 1317709
rm -f /boot/*-rescue*

# Disable network service here, as doing it in the services line
# fails due to RHBZ #1369794
systemctl disable network

# Remove machine-id on pre generated images
rm -f /etc/machine-id
touch /etc/machine-id

# set default GTK+ theme for root (see #683855, #689070, #808062)
cat > /root/.gtkrc-2.0 << EOF
include "/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc"
include "/etc/gtk-2.0/gtkrc"
gtk-theme-name="Adwaita-dark"
EOF
mkdir -p /root/.config/gtk-3.0
cat > /root/.config/gtk-3.0/settings.ini << EOF
[Settings]
gtk-theme-name = Adwaita-dark
EOF

# set livesys session type
sed -i 's/^livesys_session=.*/livesys_session="kde"/' /etc/sysconfig/livesys

# Make the calamares run on login
mkdir -p /home/liveuser/.config/autostart
cp -a /usr/share/applications/calamares.desktop /home/liveuser/.config/autostart/

# Add calamares installer desktop shortcut
mkdir /home/liveuser/Desktop
cp -a /usr/share/applications/calamares.desktop /home/liveuser/Desktop/
chmod a+x /home/liveuser/Desktop/*

# Create /usr/bin/liveuser_clean script
cat << 'EOF' > /home/liveuser/liveuser_clean
#!/bin/bash

rm /home/liveuser/Desktop/steam.desktop
rm /home/liveuser/Desktop/Return.desktop
rm /home/liveuser/Desktop/RemoteHost.desktop
rm /home/liveuser/.config/autostart/steam.desktop
EOF

# Make the script executable
chmod +x /home/liveuser/liveuser_clean

mkdir /home/liveuser/.config/autostart/
# Create /etc/xdg/autostart/liveuser_clean.desktop
cat << 'EOF' > /home/liveuser/.config/autostart/liveuser_clean.desktop
[Desktop Entry]
Type=Application
Exec=/home/liveuser/liveuser_clean
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=Liveuser Clean
Name=Liveuser Clean
Comment[en_US]=Clean up desktop files for liveuser
Comment=Clean up desktop files for liveuser
EOF

# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

# kde specific
# set up autologin
if [ -f /etc/sddm.conf ]; then
sed -i 's/^#User=.*/User=liveuser/' /etc/sddm.conf
sed -i 's/^#Session=.*/Session=plasma.desktop/' /etc/sddm.conf
else
cat << EOF >> /etc/sddm.conf
[Autologin]
User=liveuser
Session=plasma.desktop
EOF
fi

# update grub, set sddm to autolog into gamescope
cat << EOF >> /usr/share/calamares/modules/shellprocess.conf
    - command: "sed -i 's/Session=plasma/Session=gamescope-session-steam.desktop/g' /etc/sddm.conf"
      timeout: 3600
    - command: "sed -i '/Session=gamescope-session-steam.desktop/a\\\Relogin=true' /etc/sddm.conf"
      timeout: 3600
    - command: "sed -i '/\\\[Theme\\\]/a\\\Current=sugar-dark' /etc/sddm.conf"
      timeout: 3600
    - command: "sed -i \"s/GRUB_TIMEOUT='5'/GRUB_TIMEOUT='0'/g\" /etc/default/grub"
      timeout: 3600
    - command: "echo \"GRUB_TIMEOUT_STYLE='hidden'\" >> /etc/default/grub"
      timeout: 3600
    - command: "echo \"GRUB_HIDDEN_TIMEOUT='0'\" >> /etc/default/grub"
      timeout: 3600
    - command: "echo \"GRUB_HIDDEN_TIMEOUT_QUIET='true'\" >> /etc/default/grub"
      timeout: 3600
    - command: "/usr/sbin/grub2-mkconfig -o /boot/grub2/grub.cfg"
      timeout: 3600
    - command: "/usr/sbin/plymouth-set-default-theme steamos"
      timeout: 3600
    - command: "/usr/bin/dracut --regenerate-all --force"
      timeout: 3600
EOF

sed -i 's|#Current=.*|Current=sugar-dark|g' /etc/sddm.conf

sed -i 's/"quiet"/"quiet", "amdgpu.ppfeaturemask=0xffffffff"/g' /usr/share/calamares/modules/grubcfg.conf

# empty tmp files so unmount doesn't fail when unmounting /tmp due to kernel modules being installed
rm -Rf /tmp/*

%end


%packages
@^kde-desktop-environment
@anaconda-tools
@fonts
@guest-desktop-agents
@hardware-support
@kde-apps
@kde-media
@kde-pim
@kde-spin-initial-setup
@multimedia
@printing
@standard
aajohan-comfortaa-fonts
alsa-firmware
apparmor-utils
apparmor-parser
ark
apr
apr-util
calamares
chkconfig
ds-inhibit
dracut-live
fedora-release-kde
fedora-repos
fedora-workstation-repositories
firefox
ffmpegthumbs
flac-libs.x86_64
flac-libs.i686
flatpak
foomatic
fuse
gamemode.x86_64
gamemode.i686
ghc-mountpoints
gamescope
gamescope
gamescope-session-plus
gamescope-session-steam
gamescope-session-common
gamescope-htpc-common
glibc-all-langpacks
goverlay
grubby
gstreamer1-plugins-bad-free.i686
gstreamer1-plugins-bad-free.x86_64
gstreamer1-plugins-bad-free-extras.x86_64
gstreamer1-plugins-bad-free-extras.i686
gstreamer1-plugins-base.i686
gstreamer1-plugins-base.x86_64
gstreamer1-plugins-good.i686
gstreamer1-plugins-good.x86_64
gstreamer1-plugins-ugly-free.i686
gstreamer1-plugins-ugly-free.x86_64
gstreamer1.i686
gstreamer1.x86_64
hplip
initscripts
inkscape
kde-runtime
kf6-kimageformats
i2c-tools
libi2c
json-c.x86_64
json-c.i686
kde-l10n
kernel
kernel-modules
kernel-modules-extra
libaom.x86_64
libaom.i686
libICE.x86_64
libICE.i686
libSM.x86_64
libSM.i686
libXtst.x86_64
libXtst.i686
libasyncns.x86_64
libasyncns.i686
liberation-narrow-fonts.noarch
libexif.x86_64
libexif.i686
libgcc.x86_64
libgcc.i686
libieee1284.x86_64
libieee1284.i686
libogg.x86_64
libogg.i686
libsndfile.x86_64
libsndfile.i686
libunity
libuuid.x86_64
libuuid.i686
libva.x86_64
libva.i686
libvorbis.x86_64
libvorbis.i686
libwayland-client.x86_64
libwayland-client.i686
libwayland-server.x86_64
libwayland-server.i686
livesys-scripts
llvm-libs.x86_64
llvm-libs.i686
lutris
mangohud.x86_64
mangohud.i686
mariadb-connector-c
mariadb-embedded
mariadb-server
mediawriter
mesa-libOpenCL
memtest86+
mesa-libGLU.x86_64
mesa-libGLU.i686
-musescore
mscore-fonts
neofetch
nobara-login
nobara-login-sysctl
nobara-repos
nobara-controller-config
nvidia-gpu-firmware
nss-mdns.x86_64
nss-mdns.i686
ocl-icd.x86_64
ocl-icd.i686
libreoffice
openssl
openssl-libs.x86_64
openssl-libs.i686
pavucontrol-qt
protonplus-next
qemu-device-display-qxl
plasma-workspace-wallpapers
plymouth-plugin-script
python3-hid
pulseaudio-libs.x86_64
pulseaudio-libs.i686
ryzenadj
samba-common-tools.x86_64
samba-libs.x86_64
samba-winbind-clients.x86_64
samba-winbind-modules.x86_64
samba-winbind.x86_64
sane-backends-libs.x86_64
sane-backends-libs.i686
sddm-kcm
sdgyrodsu
steam
starship
kde-steamdeck
syslinux
system-config-language
tcp_wrappers-libs.x86_64
tcp_wrappers-libs.i686
umu-launcher
unixODBC.x86_64
unixODBC.i686
bsdtar
vim
vkBasalt.x86_64
vkBasalt.i686
python3-vapoursynth
vapoursynth-tools
vulkan-tools
winehq-staging
winetricks
zenity
numactl
timeshift
gcc-gfortran
okular
kate
dnfdaemon
v4l2loopback
akmod-v4l2loopback
yumex
nobara-welcome
noopenh264
openrgb
papirus-icon-theme
inputplumber
deckyloader
libavcodec-free
libavdevice-free
libavfilter-free
libavutil-free
libavformat-free
libpostproc-free
libswscale-free
libswresample-free
xwaylandvideobridge
pipewire-jack-audio-connection-kit-libs
mesa-vdpau-drivers
mesa-vdpau-drivers.i686
mesa-va-drivers
mesa-va-drivers.i686
-dnfdragora
-plasma-welcome
-gstreamer1-plugins-bad-freeworld
-gstreamer1-plugins-ugly
-gstreamer1-libav
-compat-ffmpeg4
-libavdevice
-libfreeaptx
-pipewire-codec-aptx
-libva-intel-driver
-intel-media-driver
power-profiles-daemon
-kolourpaint
-kf5-libksane
-kolourpaint-libs
-akregator
-kontact
-konversation
-krdc
-krfb
-akregator-libs
-grantlee-editor
-grantlee-editor-libs
-kf5-kross-core
-kmail
-kmail-account-wizard
-kmail-libs
-kontact-libs
-korganizer
-korganizer-libs
-pim-data-exporter
-pim-data-exporter-libs
-pim-sieve-editor
-krfb-libs
-kmahjongg
-kmines
-kpat
-freecell-solver-data
-libblack-hole-solver1
-libfreecell-solver
-libkdegames
-libkmahjongg
-libkmahjongg-data
-dragon
-kaddressbook
-akonadi-import-wizard
-cyrus-sasl-md5
-kaddressbook-libs
-kdepim-addons
-kdepim-runtime
-kdepim-runtime-libs
-kdiagram
-kf5-akonadi-calendar
-kf5-akonadi-mime
-kf5-akonadi-notes
-kf5-akonadi-search
-kf5-calendarsupport
-kf5-eventviews
-kf5-incidenceeditor
-kf5-kcalendarcore
-kf5-kcalendarutils
-kf5-kdav
-kf5-kidentitymanagement
-kf5-kimap
-kf5-kitinerary
-kf5-kldap
-kf5-kmailtransport
-kf5-kmailtransport-akonadi
-kf5-kmbox
-kf5-kontactinterface
-kf5-kpimtextedit
-kf5-kpkpass
-kf5-ksmtp
-kf5-ktnef
-kf5-libgravatar
-kf5-libkdepim
-kf5-libkleo
-kf5-libksieve
-kf5-mailcommon
-kf5-mailimporter
-kf5-mailimporter-akonadi
-kf5-messagelib
-kf5-pimcommon
-kf5-pimcommon-akonadi
-f38-backgrounds-kde
-kio-gdrive
-libkgapi
-libkolabxml
-libphonenumber
-qgpgme
-qtkeychain-qt5
-kwrite
-fedora-repos-modular
-fedora-workstation-repositories
-unoconv
-@admin-tools
-@input-methods
-device-mapper-multipath
-digikam
-fcoe-utils
-gnome-disk-utility
-iok
-isdn4k-utils
-k3b
-kipi-plugins
-krusader
-ktorrent
-mpage
-nfs-utils
-scim*
-system-config-printer
-system-config-services
-system-config-users
-xsane
-xsane-gimp
-qt5-qtwebengine-freeworld
-sushi
-abrt*
-gnome-abrt
-abrt-desktop
-abrt-java-connector
-abrt-cli
-qgnomeplatform-qt5
-qgnomeplatform-qt6
-plasma-discover
-plasma-discover-notifier
%end
