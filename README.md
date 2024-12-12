Set up mock build environment:
```
$ sudo dnf install mock pykickstart
$ sudo usermod -a -G mock $(whoami)
$ mock -r ./nobara-41-x86_64.cfg --init
$ mock -r ./nobara-41-x86_64.cfg --install lorax-lmc-novirt vim-minimal pykickstart
```

Transfer flat kickstart file to mock build environment:

```
$ cp ISO-ready-flattened-kickstarts/41/*.ks /var/lib/mock/nobara-41-x86_64/root/builddir/
```

Enter mock environment:
```
$ mock -r ./nobara-41-x86_64.cfg --shell --old-chroot --enable-network
```

From within mock environment:

Official:
```
# livemedia-creator --ks flat-nobara-live-official-41.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-41 --iso-only --iso-name Nobara-41-Official-$(date +%F).iso --releasever 41 --macboot
```

Gnome:
```
# livemedia-creator --ks flat-nobara-live-gnome-41.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-41 --iso-only --iso-name Nobara-41-GNOME-$(date +%F).iso --releasever 41 --macboot
```

KDE:
```
# livemedia-creator --ks flat-nobara-live-kde-41.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-41 --iso-only --iso-name Nobara-41-KDE-$(date +%F).iso --releasever 41 --macboot
```

Steam HTPC:
```
# livemedia-creator --ks flat-nobara-live-steam-htpc-41.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-41 --iso-only --iso-name Nobara-41-Steam-HTPC-$(date +%F).iso --releasever 41 --macboot
```

Steam Handheld:
```
# livemedia-creator --ks flat-nobara-live-steam-handheld-41.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-41 --iso-only --iso-name Nobara-41-Steam-Handheld-$(date +%F).iso --releasever 41 --macboot
```



Nvidia Official:
```
# livemedia-creator --ks nv-flat-nobara-live-official-41.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-41 --iso-only --iso-name Nobara-41-Official-NV-$(date +%F).iso --releasever 41 --macboot --extra-boot-args "modules_load=nvidia"
```

Nvidia Gnome:
```
# livemedia-creator --ks nv-flat-nobara-live-gnome-41.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-41 --iso-only --iso-name Nobara-41-GNOME-NV-$(date +%F).iso --releasever 41 --macboot --extra-boot-args "modules_load=nvidia"
```

Nvidia KDE:
```
# livemedia-creator --ks nv-flat-nobara-live-kde-41.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-41 --iso-only --iso-name Nobara-41-KDE-NV-$(date +%F).iso --releasever 41 --macboot --extra-boot-args "modules_load=nvidia"
```

Nvidia Steam HTPC:
```
# livemedia-creator --ks nv-flat-nobara-live-steam-htpc-41.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-41 --iso-only --iso-name Nobara-41-Steam-HTPC-NV-$(date +%F).iso --releasever 41 --macboot
```


Exit mock environment when build completes:
```
# exit
```

Move built ISO from mock location to whatever location you want:

```
$ sudo mv /var/lib/mock/nobara-41-x86_64/root/var/lmc/Nobara-41-*.iso .
```

Clean up mock environment:
```
$ mock -r ./nobara-41-x86_64.cfg --scrub=all
```

Finished!

Note: instructions pulled from official Fedora documentation:

https://fedoraproject.org/wiki/Livemedia-creator-_How_to_create_and_use_a_Live_CD


