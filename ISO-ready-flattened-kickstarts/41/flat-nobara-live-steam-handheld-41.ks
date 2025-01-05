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
cat > /home/liveuser/liveuser_clean << EOF
#!/bin/bash

rm /home/liveuser/Desktop/steam.desktop
rm /home/liveuser/Desktop/Return.desktop
rm /home/liveuser/Desktop/RemoteHost.desktop
rm /home/liveuser/.config/autostart/steam.desktop

rm /etc/skel/Desktop/steam.desktop
rm /etc/skel/Desktop/Return.desktop
rm /etc/skel/Desktop/RemoteHost.desktop
rm /etc/xdg/autostart/steam.desktop
EOF

# Make the script executable
chmod +x /home/liveuser/liveuser_clean

mkdir /home/liveuser/.config/autostart/
# Create /etc/xdg/autostart/liveuser_clean.desktop
cat > /home/liveuser/.config/autostart/liveuser_clean.desktop << EOF
[Desktop Entry]
Type=Application
Exec=sudo /home/liveuser/liveuser_clean
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=Liveuser Clean
Name=Liveuser Clean
Comment[en_US]=Clean up desktop files for liveuser
Comment=Clean up desktop files for liveuser
EOF

# kde specific
# set up autologin
if [ -f /etc/sddm.conf ]; then
sed -i 's/^#User=.*/User=liveuser/' /etc/sddm.conf
sed -i 's/^#Session=.*/Session=plasma.desktop/' /etc/sddm.conf
else
cat > /etc/sddm.conf << EOF
[Autologin]
User=liveuser
Session=plasma.desktop
EOF
fi

cp /usr/share/calamares/modules/shellprocess.conf.landscape /usr/share/calamares/modules/shellprocess.conf

sed -i 's|#Current=.*|Current=sugar-dark|g' /etc/sddm.conf

# Don't enable jupiter fan control in live environment
systemctl disable jupiter-fan-control
systemctl disable jupiter-controller-update

# orientation check
cat > /usr/bin/orientation-check << EOF
#!/bin/bash

# Check dmesg for the words "Galileo" or "Jupiter"

if [ -x /usr/libexec/hwsupport/sysid ]; then
  # If present, use script to clean up hardware with insignificant product name changes, such as the ROG Ally.
  SYS_ID="$(/usr/libexec/hwsupport/sysid)"
else
  SYS_ID="$(cat /sys/devices/virtual/dmi/id/product_name)"
fi
CPU_VENDOR="$(lscpu | grep "Vendor ID" | cut -d : -f 2 | xargs)"

# OXP 60Hz Devices
OXP_LIST="ONE XPLAYER:ONEXPLAYER 1 T08:ONEXPLAYER 1S A08:ONEXPLAYER 1S T08:ONEXPLAYER mini A07:ONEXPLAYER mini GA72:ONEXPLAYER mini GT72:ONEXPLAYER Mini Pro:ONEXPLAYER GUNDAM GA72:ONEXPLAYER 2 ARP23:ONEXPLAYER 2 PRO ARP23H:ONEXPLAYER 2 PRO ARP23P:ONEXPLAYER 2 PRO ARP23P EVA-01"
AOK_LIST="AOKZOE A1 AR07:AOKZOE A1 Pro"
if [[ ":$OXP_LIST:" =~ ":$SYS_ID:"  ]] || [[  ":$AOK_LIST:" =~ ":$SYS_ID:"   ]]; then
  cp /usr/share/calamares/modules/shellprocess.conf.left /usr/share/calamares/modules/shellprocess.conf
fi

# OXP 120Hz Devices
OXP_120_LIST="ONEXPLAYER F1"
if [[ ":$OXP_120_LIST:" =~ ":$SYS_ID:"  ]]; then
  cp /usr/share/calamares/modules/shellprocess.conf.left /usr/share/calamares/modules/shellprocess.conf
fi

# AYANEO AIR, SLIDE, and FLIP Keyboard Devices
AIR_LIST="AIR:AIR Pro:AIR Plus:SLIDE:FLIP KB:"
if [[ ":$AIR_LIST:" =~ ":$SYS_ID:"  ]]; then
  cp /usr/share/calamares/modules/shellprocess.conf.left /usr/share/calamares/modules/shellprocess.conf
fi

# AYANEO FLIP Dual Screen
if [[ ":FLIP DS:" =~ ":$SYS_ID:" ]]; then
  cp /usr/share/calamares/modules/shellprocess.conf.left /usr/share/calamares/modules/shellprocess.conf
fi

# AYN Loki Devices
AYN_LIST="Loki Max:Loki Zero:Loki MiniPro"
if [[ ":$AYN_LIST:" =~ ":$SYS_ID:"  ]]; then
  cp /usr/share/calamares/modules/shellprocess.conf.left /usr/share/calamares/modules/shellprocess.conf
fi

# GDP Win devices
GDP_LIST="G1619-01:G1621-02:MicroPC:WIN2"
if [[ ":$GDP_LIST:" =~ ":$SYS_ID:"  ]]; then
  cp /usr/share/calamares/modules/shellprocess.conf.right /usr/share/calamares/modules/shellprocess.conf
fi

# GPD Win 3 specifc quirk to prevent crashing
  # The GPD Win 3 does not support hardware rotation for 270/90 modes. We need to implement shader rotations to get this working correctly.
  # 0/180 rotations should work.
if [[ ":G1618-03:" =~ ":$SYS_ID:"  ]]; then
  cp /usr/share/calamares/modules/shellprocess.conf.right /usr/share/calamares/modules/shellprocess.conf
fi

#GPD Win 4 supports 40-60hz refresh rate changing
if [[ ":G1618-04:" =~ ":$SYS_ID:"  ]]; then
  cp /usr/share/calamares/modules/shellprocess.conf.landscape /usr/share/calamares/modules/shellprocess.conf
fi

# GPD Win Max 2 supports 40,60hz
if [[ ":G1619-04:" =~ ":$SYS_ID:"  ]]; then
  cp /usr/share/calamares/modules/shellprocess.conf.landscape /usr/share/calamares/modules/shellprocess.conf
fi

# GPD Win mini
if [[ ":G1617-01:" =~ ":$SYS_ID:"  ]]; then
  if ( xrandr --prop 2>$1 | grep -e "1080x1920 " > /dev/null ) ; then
     cp /usr/share/calamares/modules/shellprocess.conf.right /usr/share/calamares/modules/shellprocess.conf
  fi

  # 2024 Model w/ VRR
  if ( xrandr --prop 2>$1 | grep -e "1920x1080 " > /dev/null ) ; then
     cp /usr/share/calamares/modules/shellprocess.conf.landscape /usr/share/calamares/modules/shellprocess.conf
  fi
fi

# Steam Deck (Common)
if [[ ":Jupiter:Galileo:" =~ ":$SYS_ID:" ]]; then
  cp /usr/share/calamares/modules/shellprocess.conf.left /usr/share/calamares/modules/shellprocess.conf
fi

# Steam Deck (LCD)
if [[ ":Jupiter:" =~ ":$SYS_ID:" ]]; then
  cp /usr/share/calamares/modules/shellprocess.conf.left /usr/share/calamares/modules/shellprocess.conf
fi

# Steam Deck (OLED)
if [[ ":Galileo:" =~ ":$SYS_ID:" ]]; then
  cp /usr/share/calamares/modules/shellprocess.conf.left /usr/share/calamares/modules/shellprocess.conf
fi

# ROG Ally & ROG Ally X
if [[ ":ROG Ally RC71L:ROG Ally X RC72LA:" =~ ":$SYS_ID:" ]]; then
  cp /usr/share/calamares/modules/shellprocess.conf.landscape /usr/share/calamares/modules/shellprocess.conf
fi

# Lenovo Legion Go
if [[ ":83E1:" =~ ":$SYS_ID:"  ]]; then
  cp /usr/share/calamares/modules/shellprocess.conf.left /usr/share/calamares/modules/shellprocess.conf
fi

# Minisforum V3
if [[ ":V3:" =~ ":$SYS_ID:"  ]]; then
  cp /usr/share/calamares/modules/shellprocess.conf.landscape /usr/share/calamares/modules/shellprocess.conf
fi

if dmesg | grep -q -E "Galileo|Jupiter"; then
    # Enable jupiter-fan-control after user session starts if steam deck
    systemctl enable --now jupiter-fan-control
fi
EOF

# Enable ppfeaturemask for handhelds
sed -i 's/"quiet"/"quiet", "amdgpu.ppfeaturemask=0xffffffff"/g' /usr/share/calamares/modules/grubcfg.conf

# Make the scripts executable
chmod +x /usr/bin/orientation-check

# Create the autostart file
cat > /home/liveuser/.config/autostart/orientation-check.desktop << EOF
[Desktop Entry]
Type=Application
Exec=sudo /usr/bin/orientation-check
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Orientation Check
Comment=Run orientation-check script at startup
EOF

# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

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
gamescope-handheld-common
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
libportal
libportal-gtk4
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
opengamepadui
kde-steamdeck
steamdeck-dsp
steamdeck-firmware
jupiter-hw-support
jupiter-fan-control
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
papirus-icon-theme-dark
papirus-folders
inputplumber
opengamepadui
isomd5sum
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
sunshine
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
