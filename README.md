Set up mock build environment:
```
$ sudo dnf install mock
$ sudo usermod -a -G mock <user>
$ mock -r ./nobara-35-x86_64.cfg --init
$ mock -r ./nobara-35-x86_64.cfg --install lorax-lmc-novirt vim-minimal pykickstart
$ sudo setenforce 0
```

Transfer flat kickstart file to mock build environment:
```
$ cp ISO-ready-flattened-kickstarts/flat-nobara-live-gnome.ks /var/lib/mock/nobara-35-x86_64/root/builddir/
```

Enter mock environment:
```
$ mock -r ./nobara-35-x86_64.cfg --shell --old-chroot --enable-network
```

From within mock environment:
```
# livemedia-creator --ks flat-nobara-live-gnome.ks --no-virt --resultdir /var/lmc --project Nobara-Workstation --make-iso --volid Nobara-Workstation-35 --iso-only --iso-name Nobara-Workstation-35.iso --releasever 35 --macboot
```

Exit mock environment when build completes:
```
# exit
```

Move built ISO from mock location to whatever location you want:
```
$ sudo mv /var/lib/mock/nobara-35-x86_64/root/var/lmc/Nobara-Workstation-35.iso $HOME/
$ sudo chown <user>:<user> $HOME/Nobara-Workstation-35.iso
```

Clean up mock environment:
```
$ mock -r ./nobara-35-x86_64.cfg --clean
$ sudo setenforce 1
```

Finished!

Note: instructions pulled from official Fedora documentation:

https://fedoraproject.org/wiki/Livemedia-creator-_How_to_create_and_use_a_Live_CD
