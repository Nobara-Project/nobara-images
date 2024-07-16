Set up mock build environment:
```
$ sudo dnf install mock pykickstart
$ sudo usermod -a -G mock $(whoami)
$ mock -r ./nobara-40-x86_64.cfg --init
$ mock -r ./nobara-40-x86_64.cfg --install lorax-lmc-novirt vim-minimal pykickstart
```

Transfer flat kickstart file to mock build environment:

```
$ cp ISO-ready-flattened-kickstarts/40/*.ks /var/lib/mock/nobara-40-x86_64/root/builddir/
```

Enter mock environment:
```
$ mock -r ./nobara-40-x86_64.cfg --shell --old-chroot --enable-network
```

From within mock environment:

Official:
```
# livemedia-creator --ks flat-nobara-live-official-40.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-40 --iso-only --iso-name Nobara-40-Official-$(date +%F).iso --releasever 40 --macboot
```

Gnome:
```
# livemedia-creator --ks flat-nobara-live-gnome-40.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-40 --iso-only --iso-name Nobara-40-GNOME-$(date +%F).iso --releasever 40 --macboot
```

KDE:
```
# livemedia-creator --ks flat-nobara-live-kde-40.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-40 --iso-only --iso-name Nobara-40-KDE-$(date +%F).iso --releasever 40 --macboot
```

Steam HTPC:
```
# livemedia-creator --ks flat-nobara-live-steam-htpc-40.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-40 --iso-only --iso-name Nobara-40-Steam-HTPC-$(date +%F).iso --releasever 40 --macboot
```

Steam Handheld:
```
# livemedia-creator --ks flat-nobara-live-steam-handheld-40.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-40 --iso-only --iso-name Nobara-40-Steam-Handheld-$(date +%F).iso --releasever 40 --macboot
```



Nvidia Official:
```
# livemedia-creator --ks nv-flat-nobara-live-official-40.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-40 --iso-only --iso-name Nobara-40-Official-NV-$(date +%F).iso --releasever 40 --macboot --extra-boot-args "modules_load=nvidia"
```

Nvidia Gnome:
```
# livemedia-creator --ks nv-flat-nobara-live-gnome-40.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-40 --iso-only --iso-name Nobara-40-GNOME-NV-$(date +%F).iso --releasever 40 --macboot --extra-boot-args "modules_load=nvidia"
```

Nvidia KDE:
```
# livemedia-creator --ks nv-flat-nobara-live-kde-40.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-40 --iso-only --iso-name Nobara-40-KDE-NV-$(date +%F).iso --releasever 40 --macboot --extra-boot-args "modules_load=nvidia"
```

Nvidia Steam HTPC:
```
# livemedia-creator --ks nv-flat-nobara-live-steam-htpc-40.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-40 --iso-only --iso-name Nobara-40-Steam-HTPC-NV-$(date +%F).iso --releasever 40 --macboot
```


Exit mock environment when build completes:
```
# exit
```

Move built ISO from mock location to whatever location you want:

```
$ sudo mv /var/lib/mock/nobara-40-x86_64/root/var/lmc/Nobara-40-*.iso .
```

Clean up mock environment:
```
$ mock -r ./nobara-40-x86_64.cfg --scrub=all
```

Finished!

Note: instructions pulled from official Fedora documentation:

https://fedoraproject.org/wiki/Livemedia-creator-_How_to_create_and_use_a_Live_CD


