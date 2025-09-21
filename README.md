Set up mock build environment:
```
$ sudo dnf install pykickstart lorax lorax-lmc-novirt
```

From within mock environment:

Official:
```
# livemedia-creator --ks ISO-ready-flattened-kickstarts/flat-nobara-live-official-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-Official-$(date +%F).iso --releasever 42 --macboot
```

Gnome:
```
# livemedia-creator --ks ISO-ready-flattened-kickstarts/flat-nobara-live-gnome-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-GNOME-$(date +%F).iso --releasever 42 --macboot
```

KDE:
```
# livemedia-creator --ks ISO-ready-flattened-kickstarts/flat-nobara-live-kde-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-KDE-$(date +%F).iso --releasever 42 --macboot
```

Steam HTPC:
```
# livemedia-creator --ks ISO-ready-flattened-kickstarts/flat-nobara-live-steam-htpc-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-Steam-HTPC-$(date +%F).iso --releasever 42 --macboot
```

Steam Handheld:
```
# livemedia-creator --ks ISO-ready-flattened-kickstarts/flat-nobara-live-steam-handheld-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-Steam-Handheld-$(date +%F).iso --releasever 42 --macboot
```



Nvidia Official:
```
# livemedia-creator --ks ISO-ready-flattened-kickstarts/nv-flat-nobara-live-official-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-Official-NV-$(date +%F).iso --releasever 42 --macboot --extra-boot-args "modules_load=nvidia"
```

Nvidia Gnome:
```
# livemedia-creator --ks ISO-ready-flattened-kickstarts/nv-flat-nobara-live-gnome-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-GNOME-NV-$(date +%F).iso --releasever 42 --macboot --extra-boot-args "modules_load=nvidia"
```

Nvidia KDE:
```
# livemedia-creator --ks ISO-ready-flattened-kickstarts/nv-flat-nobara-live-kde-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-KDE-NV-$(date +%F).iso --releasever 42 --macboot --extra-boot-args "modules_load=nvidia"
```

Nvidia Steam HTPC:
```
# livemedia-creator --ks ISO-ready-flattened-kickstarts/nv-flat-nobara-live-steam-htpc-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-Steam-HTPC-NV-$(date +%F).iso --releasever 42 --macboot
```

Finished!

Note: instructions pulled from official Fedora documentation:

https://fedoraproject.org/wiki/Livemedia-creator-_How_to_create_and_use_a_Live_CD


