Set up mock build environment:
```
$ sudo dnf install mock pykickstart
$ sudo usermod -a -G mock $(whoami)
$ mock -r ./nobara-37-x86_64.cfg --init
$ mock -r ./nobara-37-x86_64.cfg --install lorax-lmc-novirt vim-minimal pykickstart
$ sudo setenforce 0
```

Transfer flat kickstart file to mock build environment:

```
$ cp ISO-ready-flattened-kickstarts/37/flat-nobara-live-*.ks /var/lib/mock/nobara-37-x86_64/root/builddir/
```

Enter mock environment:
```
$ mock -r ./nobara-37-x86_64.cfg --shell --old-chroot --enable-network
```

From within mock environment:

Official:
```
# livemedia-creator --ks flat-nobara-live-official-37.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-37 --iso-only --iso-name Nobara-37-Official-$(date +%F).iso --releasever 37 --macboot
```


Gnome:
```
# livemedia-creator --ks flat-nobara-live-gnome-37.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-37 --iso-only --iso-name Nobara-37-GNOME-$(date +%F).iso --releasever 37 --macboot
```

KDE:
```
# livemedia-creator --ks flat-nobara-live-kde-37.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-37 --iso-only --iso-name Nobara-37-KDE-$(date +%F).iso --releasever 37 --macboot
```


Exit mock environment when build completes:
```
# exit
```

Move built ISO from mock location to whatever location you want:

```
$ sudo mv /var/lib/mock/nobara-37-x86_64/root/var/lmc/Nobara-37-*.iso .
```

Clean up mock environment:
```
$ mock -r ./nobara-37-x86_64.cfg --scrub=all
$ sudo setenforce 1
```

Finished!

Note: instructions pulled from official Fedora documentation:

https://fedoraproject.org/wiki/Livemedia-creator-_How_to_create_and_use_a_Live_CD


