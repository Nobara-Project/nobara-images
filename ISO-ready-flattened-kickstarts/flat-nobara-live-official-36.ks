# Generated by pykickstart v3.36
#version=F36
# X Window System configuration information
xconfig  --startxonboot
# Keyboard layouts
keyboard 'us'
# Root password
rootpw --iscrypted --lock locked
# System language
lang en_US.UTF-8
# Shutdown after installation
shutdown
# Network information
network  --bootproto=dhcp --device=link --activate
# Firewall configuration
firewall --enabled --service=mdns
# Use network installation
url --mirrorlist="https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch"
repo --name="nobara-base" --baseurl=https://download.copr.fedorainfracloud.org/results/gloriouseggroll/nobara/fedora-$releasever-$basearch/
repo --name="nobara-base-i386" --baseurl=https://download.copr.fedorainfracloud.org/results/gloriouseggroll/nobara/fedora-$releasever-i386/
repo --name="nobara-theming" --baseurl=https://download.copr.fedorainfracloud.org/results/gloriouseggroll/nobara-theming/fedora-$releasever-$basearch/
repo --name="nobara-mesa-git" --baseurl=https://download.copr.fedorainfracloud.org/results/gloriouseggroll/mesa-aco/fedora-$releasever-$basearch/
repo --name="nobara-mesa-git-i386" --baseurl=https://download.copr.fedorainfracloud.org/results/gloriouseggroll/mesa-aco/fedora-$releasever-i386/
repo --name="nobara-kernel-fsync" --baseurl=https://download.copr.fedorainfracloud.org/results/sentry/kernel-fsync/fedora-$releasever-$basearch/
repo --name="nobara-glibc" --baseurl=https://download.copr.fedorainfracloud.org/results/gloriouseggroll/glibc/fedora-$releasever-$basearch/
repo --name="nobara-glibc-i386" --baseurl=https://download.copr.fedorainfracloud.org/results/gloriouseggroll/glibc/fedora-$releasever-i386/
repo --name="nobara-gameutils" --baseurl=https://download.copr.fedorainfracloud.org/results/gloriouseggroll/game-utils/fedora-$releasever-$basearch/
repo --name="nobara-gameutils-i386" --baseurl=https://download.copr.fedorainfracloud.org/results/gloriouseggroll/game-utils/fedora-$releasever-i386/
repo --name="nobara-obs-studio" --baseurl=https://www.nobaraproject.org/repo/fedora/$releasever/$basearch/obs-studio-nobara/
repo --name="nobara-obs-studio-gamecapture" --baseurl=https://download.copr.fedorainfracloud.org/results/gloriouseggroll/obs-studio-gamecapture/fedora-$releasever-$basearch/
repo --name="nobara-obs-studio-gamecapture-i386" --baseurl=https://download.copr.fedorainfracloud.org/results/gloriouseggroll/obs-studio-gamecapture/fedora-$releasever-i386/
repo --name="fedora" --mirrorlist=http://mirrors.fedoraproject.org/metalink?repo=fedora-$releasever&arch=$basearch --excludepkgs="fedora-repos,kernel,kernel-core,kernel-modules,kernel-devel*,kernel-modules-extra,glibc*,dnf,dnf-automatic,dnf-data,python3-dnf,yum,dnfdaemon*,libnsl,mesa*,nautilus*,pciutils,gst-editing-services,rygel,lutris,gnome-shell,gnome-initial-setup,dnfdragora,vkBasalt*,mangohud*,gamescope*,libliftoff*,blender*,fedora-workstation-repositories,flatpak*,setup,mutter*,gnome-control-center*,gnome-shell-extension-sound-output-device-chooser,gnome-extensions-app,wine-desktop,wine-core,wine,winetricks,gnome-shell-extension-pop-shell"
repo --name="fedora-updates" --mirrorlist=http://mirrors.fedoraproject.org/metalink?repo=updates-released-f$releasever&arch=$basearch --excludepkgs="fedora-repos,kernel,kernel-core,kernel-modules,kernel-devel*,kernel-modules-extra,glibc*,dnf,dnf-automatic,dnf-data,python3-dnf,yum,dnfdaemon*,libnsl,mesa*,nautilus*,pciutils,gst-editing-services,rygel,lutris,gnome-shell,gnome-initial-setup,dnfdragora,vkBasalt*,mangohud*,gamescope*,libliftoff*,blender*,fedora-workstation-repositories,flatpak*,setup,mutter*,gnome-control-center*,gnome-shell-extension-sound-output-device-chooser,gnome-extensions-app,wine-desktop,wine-core,wine,winetricks,gnome-shell-extension-pop-shell"
repo --name="rpmfusion-free" --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-$releasever&arch=$basearch --excludepkgs="obs-studio"
repo --name="rpmfusion-free-updates" --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-updates-released-$releasever&arch=$basearch --excludepkgs="obs-studio"
repo --name="rpmfusion-nonfree" --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-$releasever&arch=$basearch --excludepkgs="discord"
repo --name="rpmfusion-nonfree-updates" --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-released-$releasever&arch=$basearch --excludepkgs="discord"
repo --name="rpmfusion-nonfree-nvidia" --mirrorlist=https://mirrors.rpmfusion.org/metalink?repo=nonfree-fedora-nvidia-driver-$releasever&arch=$basearch
repo --name="rpmfusion-nonfree-steam" --mirrorlist=https://mirrors.rpmfusion.org/metalink?repo=nonfree-fedora-steam-$releasever&arch=$basearch
repo --name="WineHQ-Official" --baseurl=https://dl.winehq.org/wine-builds/fedora/36
# System timezone
timezone US/Eastern
# SELinux configuration
selinux --permissive
# System services
services --disabled="sshd" --enabled="NetworkManager,ModemManager"
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
# FIXME: it'd be better to get this installed from a package
cat > /etc/rc.d/init.d/livesys << EOF
#!/bin/bash
#
# live: Init script for live image
#
# chkconfig: 345 00 99
# description: Init script for live image.
### BEGIN INIT INFO
# X-Start-Before: display-manager chronyd
### END INIT INFO

. /etc/init.d/functions

if ! strstr "\`cat /proc/cmdline\`" rd.live.image || [ "\$1" != "start" ]; then
    exit 0
fi

if [ -e /.liveimg-configured ] ; then
    configdone=1
fi

exists() {
    which \$1 >/dev/null 2>&1 || return
    \$*
}

livedir="LiveOS"
for arg in \`cat /proc/cmdline\` ; do
  if [ "\${arg##rd.live.dir=}" != "\${arg}" ]; then
    livedir=\${arg##rd.live.dir=}
    continue
  fi
  if [ "\${arg##live_dir=}" != "\${arg}" ]; then
    livedir=\${arg##live_dir=}
  fi
done

# enable swapfile if it exists
if ! strstr "\`cat /proc/cmdline\`" noswap && [ -f /run/initramfs/live/\${livedir}/swap.img ] ; then
  action "Enabling swap file" swapon /run/initramfs/live/\${livedir}/swap.img
fi

mountPersistentHome() {
  # support label/uuid
  if [ "\${homedev##LABEL=}" != "\${homedev}" -o "\${homedev##UUID=}" != "\${homedev}" ]; then
    homedev=\`/sbin/blkid -o device -t "\$homedev"\`
  fi

  # if we're given a file rather than a blockdev, loopback it
  if [ "\${homedev##mtd}" != "\${homedev}" ]; then
    # mtd devs don't have a block device but get magic-mounted with -t jffs2
    mountopts="-t jffs2"
  elif [ ! -b "\$homedev" ]; then
    loopdev=\`losetup -f\`
    if [ "\${homedev##/run/initramfs/live}" != "\${homedev}" ]; then
      action "Remounting live store r/w" mount -o remount,rw /run/initramfs/live
    fi
    losetup \$loopdev \$homedev
    homedev=\$loopdev
  fi

  # if it's encrypted, we need to unlock it
  if [ "\$(/sbin/blkid -s TYPE -o value \$homedev 2>/dev/null)" = "crypto_LUKS" ]; then
    echo
    echo "Setting up encrypted /home device"
    plymouth ask-for-password --command="cryptsetup luksOpen \$homedev EncHome"
    homedev=/dev/mapper/EncHome
  fi

  # and finally do the mount
  mount \$mountopts \$homedev /home
  # if we have /home under what's passed for persistent home, then
  # we should make that the real /home.  useful for mtd device on olpc
  if [ -d /home/home ]; then mount --bind /home/home /home ; fi
  [ -x /sbin/restorecon ] && /sbin/restorecon /home
  if [ -d /home/liveuser ]; then USERADDARGS="-M" ; fi
}

findPersistentHome() {
  for arg in \`cat /proc/cmdline\` ; do
    if [ "\${arg##persistenthome=}" != "\${arg}" ]; then
      homedev=\${arg##persistenthome=}
    fi
  done
}

if strstr "\`cat /proc/cmdline\`" persistenthome= ; then
  findPersistentHome
elif [ -e /run/initramfs/live/\${livedir}/home.img ]; then
  homedev=/run/initramfs/live/\${livedir}/home.img
fi

# if we have a persistent /home, then we want to go ahead and mount it
if ! strstr "\`cat /proc/cmdline\`" nopersistenthome && [ -n "\$homedev" ] ; then
  action "Mounting persistent /home" mountPersistentHome
fi

if [ -n "\$configdone" ]; then
  exit 0
fi

# add liveuser user with no passwd
action "Adding live user" useradd \$USERADDARGS -c "Live System User" liveuser
passwd -d liveuser > /dev/null
usermod -aG wheel liveuser > /dev/null

# Remove root password lock
passwd -d root > /dev/null

# turn off firstboot for livecd boots
systemctl --no-reload disable firstboot-text.service 2> /dev/null || :
systemctl --no-reload disable firstboot-graphical.service 2> /dev/null || :
systemctl stop firstboot-text.service 2> /dev/null || :
systemctl stop firstboot-graphical.service 2> /dev/null || :

# don't use prelink on a running live image
sed -i 's/PRELINKING=yes/PRELINKING=no/' /etc/sysconfig/prelink &>/dev/null || :

# turn off mdmonitor by default
systemctl --no-reload disable mdmonitor.service 2> /dev/null || :
systemctl --no-reload disable mdmonitor-takeover.service 2> /dev/null || :
systemctl stop mdmonitor.service 2> /dev/null || :
systemctl stop mdmonitor-takeover.service 2> /dev/null || :

# don't start cron/at as they tend to spawn things which are
# disk intensive that are painful on a live image
systemctl --no-reload disable crond.service 2> /dev/null || :
systemctl --no-reload disable atd.service 2> /dev/null || :
systemctl stop crond.service 2> /dev/null || :
systemctl stop atd.service 2> /dev/null || :

# turn off abrtd on a live image
systemctl --no-reload disable abrtd.service 2> /dev/null || :
systemctl stop abrtd.service 2> /dev/null || :

# Don't sync the system clock when running live (RHBZ #1018162)
sed -i 's/rtcsync//' /etc/chrony.conf

# Mark things as configured
touch /.liveimg-configured

# add static hostname to work around xauth bug
# https://bugzilla.redhat.com/show_bug.cgi?id=679486
# the hostname must be something else than 'localhost'
# https://bugzilla.redhat.com/show_bug.cgi?id=1370222
hostnamectl set-hostname "localhost-live"

EOF

# bah, hal starts way too late
cat > /etc/rc.d/init.d/livesys-late << EOF
#!/bin/bash
#
# live: Late init script for live image
#
# chkconfig: 345 99 01
# description: Late init script for live image.

. /etc/init.d/functions

if ! strstr "\`cat /proc/cmdline\`" rd.live.image || [ "\$1" != "start" ] || [ -e /.liveimg-late-configured ] ; then
    exit 0
fi

exists() {
    which \$1 >/dev/null 2>&1 || return
    \$*
}

touch /.liveimg-late-configured

# read some variables out of /proc/cmdline
for o in \`cat /proc/cmdline\` ; do
    case \$o in
    ks=*)
        ks="--kickstart=\${o#ks=}"
        ;;
    xdriver=*)
        xdriver="\${o#xdriver=}"
        ;;
    esac
done

# if liveinst or textinst is given, start anaconda
if strstr "\`cat /proc/cmdline\`" liveinst ; then
   plymouth --quit
   /usr/sbin/liveinst \$ks
fi
if strstr "\`cat /proc/cmdline\`" textinst ; then
   plymouth --quit
   /usr/sbin/liveinst --text \$ks
fi

# configure X, allowing user to override xdriver
if [ -n "\$xdriver" ]; then
   cat > /etc/X11/xorg.conf.d/00-xdriver.conf <<FOE
Section "Device"
	Identifier	"Videocard0"
	Driver	"\$xdriver"
EndSection
FOE
fi

EOF

chmod 755 /etc/rc.d/init.d/livesys
/sbin/restorecon /etc/rc.d/init.d/livesys
/sbin/chkconfig --add livesys

chmod 755 /etc/rc.d/init.d/livesys-late
/sbin/restorecon /etc/rc.d/init.d/livesys-late
/sbin/chkconfig --add livesys-late

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
/sbin/chkconfig network off

# Remove machine-id on pre generated images
rm -f /etc/machine-id
touch /etc/machine-id

%end

%post --nochroot
# For livecd-creator builds only (lorax/livemedia-creator handles this directly)
if [ -n "$LIVE_ROOT" ]; then
    cp "$INSTALL_ROOT"/usr/share/licenses/*-release-common/* "$LIVE_ROOT/"

    # only installed on x86, x86_64
    if [ -f /usr/bin/livecd-iso-to-disk ]; then
        mkdir -p "$LIVE_ROOT/LiveOS"
        cp /usr/bin/livecd-iso-to-disk "$LIVE_ROOT/LiveOS"
    fi
fi

%end

%post

cat >> /etc/rc.d/init.d/livesys << EOF


# disable gnome-software automatically downloading updates
cat >> /usr/share/glib-2.0/schemas/org.gnome.software.gschema.override << FOE
[org.gnome.software]
download-updates=false
FOE

# don't autostart gnome-software session service
rm -f /etc/xdg/autostart/gnome-software-service.desktop

# disable the gnome-software shell search provider
cat >> /usr/share/gnome-shell/search-providers/org.gnome.Software-search-provider.ini << FOE
DefaultDisabled=true
FOE

# don't run gnome-initial-setup
mkdir ~liveuser/.config
touch ~liveuser/.config/gnome-initial-setup-done

# suppress anaconda spokes redundant with gnome-initial-setup
cat >> /etc/sysconfig/anaconda << FOE
[NetworkSpoke]
visited=1

[PasswordSpoke]
visited=1

[UserSpoke]
visited=1
FOE

# make the installer show up
if [ -f /usr/share/applications/liveinst.desktop ]; then
  # Show harddisk install in shell dash
  sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop ""
  # need to move it to anaconda.desktop to make shell happy
  mv /usr/share/applications/liveinst.desktop /usr/share/applications/anaconda.desktop

  cat >> /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.override << FOE
[org.gnome.shell]
favorite-apps=['firefox.desktop', 'org.gnome.Calendar.desktop', 'rhythmbox.desktop', 'org.gnome.Photos.desktop', 'org.gnome.Nautilus.desktop', 'anaconda.desktop']
FOE

  # Make the welcome screen show up
  if [ -f /usr/share/anaconda/gnome/fedora-welcome.desktop ]; then
    mkdir -p ~liveuser/.config/autostart
    cp /usr/share/anaconda/gnome/fedora-welcome.desktop /usr/share/applications/
    cp /usr/share/anaconda/gnome/fedora-welcome.desktop ~liveuser/.config/autostart/
  fi

  # Disable GNOME welcome tour so it doesn't overlap with Fedora welcome screen
  cat >> /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.override << FOE
welcome-dialog-last-shown-version='4294967295'
FOE

  # Copy Anaconda branding in place
  if [ -d /usr/share/lorax/product/usr/share/anaconda ]; then
    cp -a /usr/share/lorax/product/* /
  fi
fi

# rebuild schema cache with any overrides we installed
glib-compile-schemas /usr/share/glib-2.0/schemas

# set up auto-login
cat > /etc/gdm/custom.conf << FOE
[daemon]
AutomaticLoginEnable=True
AutomaticLogin=liveuser
WaylandEnable=false
DefaultSession=gnome-xorg.desktop
FOE

# Turn off PackageKit-command-not-found while uninstalled
if [ -f /etc/PackageKit/CommandNotFound.conf ]; then
  sed -i -e 's/^SoftwareSourceSearch=true/SoftwareSourceSearch=false/' /etc/PackageKit/CommandNotFound.conf
fi

# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

EOF

%end

%packages
@^workstation-product-environment
@anaconda-tools
@firefox
@fonts
@hardware-support
@libreoffice
@multimedia
@networkmanager-submodules
@printing
@x86-baremetal-tools
aajohan-comfortaa-fonts
anaconda
anaconda-install-env-deps
anaconda-live
file-roller
blender
chkconfig
dracut-live
egl-gbm
egl-wayland
fedora-repos
flac-libs.x86_64
flac-libs.i686
foomatic
gamemode
gamemode.i686
gamescope
glibc-all-langpacks
gnome-extension-manager
gnome-icon-theme
gnome-shell-extension-arc-menu
gnome-shell-extension-blur-my-shell
gnome-shell-extension-dash-to-panel
gnome-shell-extension-pop-shell
gnome-shell-extension-sound-output-device-chooser
gnome-shell-extension-application-volume-mixer
gnome-shell-extension-desktop-icons
gnome-shell-nobara-theming
goverlay
gsettings-desktop-schemas 
gstreamer1-libav.i686
gstreamer1-libav.x86_64
gstreamer1-plugins-bad-free.i686
gstreamer1-plugins-bad-free.x86_64
gstreamer1-plugins-bad-freeworld.i686
gstreamer1-plugins-bad-freeworld.x86_64
gstreamer1-plugins-base.i686
gstreamer1-plugins-base.x86_64
gstreamer1-plugins-good.i686
gstreamer1-plugins-good.x86_64
gstreamer1-plugins-ugly-free.i686
gstreamer1-plugins-ugly-free.x86_64
gstreamer1-plugins-ugly.i686
gstreamer1-plugins-ugly.x86_64
gstreamer1.i686
gstreamer1.x86_64
hplip
hplip-gui
initscripts
json-c.x86_64
json-c.i686
kdenlive
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
libreoffice-draw
libreoffice-math
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
llvm-libs.x86_64
llvm-libs.i686
lutris
mangohud.x86_64
mangohud.i686
mariadb-connector-c
mariadb-embedded
mariadb-server
mediawriter
memtest86+
neofetch
nautilus-terminal
nobara-login
nobara-login-sysctl
nobara-repos
nobara-theming-repos
nobara-controller-config
nss-mdns.x86_64
nss-mdns.i686
obs-studio
obs-studio-gamecapture.x86_64
obs-studio-gamecapture.i686
ocl-icd.x86_64
ocl-icd.i686
openssl
openssl-libs.x86_64
openssl-libs.i686
pavucontrol
pipewire-codec-aptx
protonup-qt
pulseaudio-libs.x86_64
pulseaudio-libs.i686
rpmfusion-free-release
samba-common-tools.x86_64
samba-libs.x86_64
samba-winbind-clients.x86_64
samba-winbind-modules.x86_64
samba-winbind.x86_64
sane-backends-libs.x86_64
sane-backends-libs.i686
steam
syslinux
system-config-language
tcp_wrappers-libs.x86_64
tcp_wrappers-libs.i686
unixODBC.x86_64
unixODBC.i686
vim
vlc
vkBasalt.x86_64
vkBasalt.i686
vulkan-tools
winehq-staging
winetricks
yumex-dnf
zenity
-@dial-up
-@input-methods
-@standard
-device-mapper-multipath
-fcoe-utils
-gfs2-utils
-gst-editing-services
-okular
-reiserfs-utils
-rygel
-gnome-shell-extension-gamemode

%end
