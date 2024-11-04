#!/bin/bash

rm -Rf /var/lmc
rm -Rf /var/run/anaconda.pid


livemedia-creator --ks flat-nobara-live-official-40.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-40 --iso-only --iso-name Nobara-40-Official-$(date +%F).iso --releasever 40 --macboot

mv /var/lmc/*.iso .
rm -Rf /var/lmc/

livemedia-creator --ks flat-nobara-live-gnome-40.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-40 --iso-only --iso-name Nobara-40-GNOME-$(date +%F).iso --releasever 40 --macboot

mv /var/lmc/*.iso .
rm -Rf /var/lmc/

livemedia-creator --ks flat-nobara-live-kde-40.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-40 --iso-only --iso-name Nobara-40-KDE-$(date +%F).iso --releasever 40 --macboot

mv /var/lmc/*.iso .
rm -Rf /var/lmc/

livemedia-creator --ks flat-nobara-live-steam-htpc-40.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-40 --iso-only --iso-name Nobara-40-Steam-HTPC-$(date +%F).iso --releasever 40 --macboot

mv /var/lmc/*.iso .
rm -Rf /var/lmc/

livemedia-creator --ks flat-nobara-live-steam-handheld-40.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-40 --iso-only --iso-name Nobara-40-Steam-Handheld-$(date +%F).iso --releasever 40 --macboot

mv /var/lmc/*.iso .
rm -Rf /var/lmc/

livemedia-creator --ks nv-flat-nobara-live-official-40.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-40 --iso-only --iso-name Nobara-40-Official-Nvidia-$(date +%F).iso --releasever 40 --macboot --extra-boot-args "modules_load=nvidia"

mv /var/lmc/*.iso .
rm -Rf /var/lmc/

livemedia-creator --ks nv-flat-nobara-live-gnome-40.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-40 --iso-only --iso-name Nobara-40-GNOME-Nvidia-$(date +%F).iso --releasever 40 --macboot --extra-boot-args "modules_load=nvidia"

mv /var/lmc/*.iso .
rm -Rf /var/lmc/

livemedia-creator --ks nv-flat-nobara-live-kde-40.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-40 --iso-only --iso-name Nobara-40-KDE-Nvidia-$(date +%F).iso --releasever 40 --macboot --extra-boot-args "modules_load=nvidia"

mv /var/lmc/*.iso .
rm -Rf /var/lmc/

livemedia-creator --ks nv-flat-nobara-live-steam-htpc-40.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-40 --iso-only --iso-name Nobara-40-Steam-HTPC-Nvidia-$(date +%F).iso --releasever 40 --macboot --extra-boot-args "modules_load=nvidia"

mv /var/lmc/*.iso .
rm -Rf /var/lmc/

