#!/bin/bash

rm -Rf /var/lmc
rm -Rf /var/run/anaconda.pid

mkdir builds


livemedia-creator --ks flat-nobara-live-official-41.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-41 --iso-only --iso-name Nobara-41-Official-$(date +%F).iso --releasever 41 --macboot

mv /var/lmc/*.iso builds/
rm -Rf /var/lmc/

livemedia-creator --ks flat-nobara-live-gnome-41.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-41 --iso-only --iso-name Nobara-41-GNOME-$(date +%F).iso --releasever 41 --macboot

mv /var/lmc/*.iso builds/
rm -Rf /var/lmc/

livemedia-creator --ks flat-nobara-live-kde-41.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-41 --iso-only --iso-name Nobara-41-KDE-$(date +%F).iso --releasever 41 --macboot

mv /var/lmc/*.iso builds/
rm -Rf /var/lmc/

livemedia-creator --ks flat-nobara-live-steam-htpc-41.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-41 --iso-only --iso-name Nobara-41-Steam-HTPC-$(date +%F).iso --releasever 41 --macboot

mv /var/lmc/*.iso builds/
rm -Rf /var/lmc/

livemedia-creator --ks flat-nobara-live-steam-handheld-41.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-41 --iso-only --iso-name Nobara-41-Steam-Handheld-$(date +%F).iso --releasever 41 --macboot --extra-boot-args "video=efifb fbcon=rotate:1"

mv /var/lmc/*.iso builds/
rm -Rf /var/lmc/

livemedia-creator --ks nv-flat-nobara-live-official-41.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-41 --iso-only --iso-name Nobara-41-Official-Nvidia-$(date +%F).iso --releasever 41 --macboot --extra-boot-args "modules_load=nvidia"

mv /var/lmc/*.iso builds/
rm -Rf /var/lmc/

livemedia-creator --ks nv-flat-nobara-live-gnome-41.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-41 --iso-only --iso-name Nobara-41-GNOME-Nvidia-$(date +%F).iso --releasever 41 --macboot --extra-boot-args "modules_load=nvidia"

mv /var/lmc/*.iso builds/
rm -Rf /var/lmc/

livemedia-creator --ks nv-flat-nobara-live-kde-41.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-41 --iso-only --iso-name Nobara-41-KDE-Nvidia-$(date +%F).iso --releasever 41 --macboot --extra-boot-args "modules_load=nvidia"

mv /var/lmc/*.iso builds/
rm -Rf /var/lmc/

livemedia-creator --ks nv-flat-nobara-live-steam-htpc-41.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-41 --iso-only --iso-name Nobara-41-Steam-HTPC-Nvidia-$(date +%F).iso --releasever 41 --macboot --extra-boot-args "modules_load=nvidia"

mv /var/lmc/*.iso builds/
rm -Rf /var/lmc/

