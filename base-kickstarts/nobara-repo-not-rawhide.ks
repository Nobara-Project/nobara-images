repo --install --name=nobara --baseurl=https://download.copr.fedorainfracloud.org/results/gloriouseggroll/nobara/fedora-$releasever-$basearch/
repo --install --name=nobara-i386 --baseurl=https://download.copr.fedorainfracloud.org/results/gloriouseggroll/nobara/fedora-$releasever-i386/

#todo: move these into the nobara repo
repo --install --name=nobara-mesa-git --baseurl=https://download.copr.fedorainfracloud.org/results/gloriouseggroll/mesa-aco/fedora-$releasever-$basearch/
repo --install --name=nobara-mesa-git-i386 --baseurl=https://download.copr.fedorainfracloud.org/results/gloriouseggroll/mesa-aco/fedora-$releasever-i386/
repo --install --name=nobara-kernel-fsync --baseurl=https://download.copr.fedorainfracloud.org/results/sentry/kernel-fsync/fedora-$releasever-$basearch/
repo --install --name=nobara-xow --baseurl=https://download.copr.fedorainfracloud.org/results/sentry/xow/fedora-$releasever-$basearch/

repo --name=fedora --mirrorlist=http://mirrors.fedoraproject.org/metalink?repo=fedora-$releasever&arch=$basearch --excludepkgs=fedora-repos,kernel*,mesa*,libusb1,libusbx,pciutils,gst-editing-services,rygel,lutris,gdm
repo --name=updates --mirrorlist=http://mirrors.fedoraproject.org/metalink?repo=updates-released-f$releasever&arch=$basearch --excludepkgs=fedora-repos,kernel*,mesa*,libusb1,libusbx,pciutils,gst-editing-services,rygel,lutris,gdm

repo --name=rpmfusion-free --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-$releasever&arch=$basearch
repo --name=rpmfusion-free-updates --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-updates-released-$releasever&arch=$basearch
repo --name=rpmfusion-nonfree --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-$releasever&arch=$basearch
repo --name=rpmfusion-nonfree-updates --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-released-$releasever&arch=$basearch

url --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch
