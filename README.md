Set up mock build environment:
```
$ sudo dnf install mock pykickstart
$ sudo usermod -a -G mock <user>
$ mock -r ./nobara-35-x86_64.cfg --init
$ mock -r ./nobara-35-x86_64.cfg --install lorax-lmc-novirt vim-minimal pykickstart
$ sudo setenforce 0
```

Transfer flat kickstart file to mock build environment:

Gnome:
```
$ cp ISO-ready-flattened-kickstarts/flat-nobara-live-gnome.ks /var/lib/mock/nobara-35-x86_64/root/builddir/
```

KDE:
```
$ cp ISO-ready-flattened-kickstarts/flat-nobara-live-kde.ks /var/lib/mock/nobara-35-x86_64/root/builddir/
```

Enter mock environment:
```
$ mock -r ./nobara-35-x86_64.cfg --shell --old-chroot --enable-network
```

From within mock environment:

Gnome:
```
# livemedia-creator --ks flat-nobara-live-gnome.ks --no-virt --resultdir /var/lmc --project Nobara-Workstation --make-iso --volid Nobara-Workstation-35 --iso-only --iso-name Nobara-Workstation-35.iso --releasever 35 --macboot
```

KDE:
```
# livemedia-creator --ks flat-nobara-live-kde.ks --no-virt --resultdir /var/lmc --project Nobara-Workstation --make-iso --volid Nobara-Workstation-35 --iso-only --iso-name Nobara-Workstation-35-KDE.iso --releasever 35 --macboot
```


Exit mock environment when build completes:
```
# exit
```

Move built ISO from mock location to whatever location you want:

Gnome:
```
$ sudo mv /var/lib/mock/nobara-35-x86_64/root/var/lmc/Nobara-Workstation-35.iso .
```

KDE:
```
$ sudo mv /var/lib/mock/nobara-35-x86_64/root/var/lmc/Nobara-Workstation-35-KDE.iso .
```

Clean up mock environment:
```
$ mock -r ./nobara-35-x86_64.cfg --clean
$ sudo setenforce 1
```

Finished!

Note: instructions pulled from official Fedora documentation:

https://fedoraproject.org/wiki/Livemedia-creator-_How_to_create_and_use_a_Live_CD

Note 2:

How to re-flatten kickstarts after modifications:

Gnome:
```
# ksflatten --config base-kickstarts/nobara-live-gnome.ks -o ISO-ready-flattened-kickstarts/flat-nobara-live-gnome.ks --version F35
```

KDE:
```
# ksflatten --config base-kickstarts/nobara-live-kde.ks -o ISO-ready-flattened-kickstarts/flat-nobara-live-kde.ks --version F35
```
