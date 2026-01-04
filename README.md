Set up mock build environment:
```
mock -r ./nobara-43-x86_64.cfg --clean
mock -r ./nobara-43-x86_64.cfg --install lorax-lmc-novirt vim-minimal pykickstart
mock -r ./nobara-43-x86_64.cfg --shell --enable-network
```

From within mock environment:

Official:
```
# livemedia-creator --ks flat-nobara-live-official-43.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-43 --iso-only --iso-name Nobara-43-Official-$(date +%F).iso --releasever 43 --macboot
```

Gnome:
```
# livemedia-creator --ks flat-nobara-live-gnome-43.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-43 --iso-only --iso-name Nobara-43-GNOME-$(date +%F).iso --releasever 43 --macboot
```

KDE:
```
# livemedia-creator --ks flat-nobara-live-kde-43.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-43 --iso-only --iso-name Nobara-43-KDE-$(date +%F).iso --releasever 43 --macboot
```

Steam HTPC:
```
# livemedia-creator --ks flat-nobara-live-steam-htpc-43.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-43 --iso-only --iso-name Nobara-43-Steam-HTPC-$(date +%F).iso --releasever 43 --macboot
```

Steam Handheld:
```
# livemedia-creator --ks flat-nobara-live-steam-handheld-43.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-43 --iso-only --iso-name Nobara-43-Steam-Handheld-$(date +%F).iso --releasever 43 --macboot
```



Nvidia Official:
```
# livemedia-creator --ks nv-flat-nobara-live-official-43.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-43 --iso-only --iso-name Nobara-43-Official-NV-$(date +%F).iso --releasever 43 --macboot --extra-boot-args "modules_load=nvidia"
```

Nvidia Gnome:
```
# livemedia-creator --ks nv-flat-nobara-live-gnome-43.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-43 --iso-only --iso-name Nobara-43-GNOME-NV-$(date +%F).iso --releasever 43 --macboot --extra-boot-args "modules_load=nvidia"
```

Nvidia KDE:
```
# livemedia-creator --ks nv-flat-nobara-live-kde-43.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-43 --iso-only --iso-name Nobara-43-KDE-NV-$(date +%F).iso --releasever 43 --macboot --extra-boot-args "modules_load=nvidia"
```

Nvidia Steam HTPC:
```
# livemedia-creator --ks nv-flat-nobara-live-steam-htpc-43.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-43 --iso-only --iso-name Nobara-43-Steam-HTPC-NV-$(date +%F).iso --releasever 43 --macboot
```

exit

sudo mv /var/lib/mock/nobara-43-x86_64/root/builddir/release .

Finished!

Note: instructions pulled from official Fedora documentation:

https://fedoraproject.org/wiki/Livemedia-creator-_How_to_create_and_use_a_Live_CD


