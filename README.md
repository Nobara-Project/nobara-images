Set up mock build environment:
```
$ sudo dnf install mock pykickstart
$ sudo usermod -a -G mock $(whoami)
$ mock -r ./nobara-42-x86_64.cfg --init
$ mock -r ./nobara-42-x86_64.cfg --install lorax-lmc-novirt vim-minimal pykickstart
```

Transfer flat kickstart file to mock build environment:

```
$ cp ISO-ready-flattened-kickstarts/42/*.ks /var/lib/mock/nobara-42-x86_64/root/builddir/
```

Enter mock environment:
```
$ mock -r ./nobara-42-x86_64.cfg --shell --old-chroot --enable-network
```

From within mock environment:

Official:
```
# livemedia-creator --ks flat-nobara-live-official-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-Official-$(date +%F).iso --releasever 42 --macboot
```

Gnome:
```
# livemedia-creator --ks flat-nobara-live-gnome-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-GNOME-$(date +%F).iso --releasever 42 --macboot
```

KDE:
```
# livemedia-creator --ks flat-nobara-live-kde-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-KDE-$(date +%F).iso --releasever 42 --macboot
```

Steam HTPC:
```
# livemedia-creator --ks flat-nobara-live-steam-htpc-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-Steam-HTPC-$(date +%F).iso --releasever 42 --macboot
```

Steam Handheld:
```
# livemedia-creator --ks flat-nobara-live-steam-handheld-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-Steam-Handheld-$(date +%F).iso --releasever 42 --macboot
```



Nvidia Official:
```
# livemedia-creator --ks nv-flat-nobara-live-official-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-Official-NV-$(date +%F).iso --releasever 42 --macboot --extra-boot-args "modules_load=nvidia"
```

Nvidia Gnome:
```
# livemedia-creator --ks nv-flat-nobara-live-gnome-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-GNOME-NV-$(date +%F).iso --releasever 42 --macboot --extra-boot-args "modules_load=nvidia"
```

Nvidia KDE:
```
# livemedia-creator --ks nv-flat-nobara-live-kde-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-KDE-NV-$(date +%F).iso --releasever 42 --macboot --extra-boot-args "modules_load=nvidia"
```

Nvidia Steam HTPC:
```
# livemedia-creator --ks nv-flat-nobara-live-steam-htpc-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-Steam-HTPC-NV-$(date +%F).iso --releasever 42 --macboot
```


Exit mock environment when build completes:
```
# exit
```

Move built ISO from mock location to whatever location you want:

```
$ sudo mv /var/lib/mock/nobara-42-x86_64/root./release/Nobara-42-*.iso .
```

Clean up mock environment:
```
$ mock -r ./nobara-42-x86_64.cfg --scrub=all
```

Finished!

Note: instructions pulled from official Fedora documentation:

https://fedoraproject.org/wiki/Livemedia-creator-_How_to_create_and_use_a_Live_CD


