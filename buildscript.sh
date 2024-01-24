#!/bin/bash

rm -Rf /var/lmc
rm -Rf /var/run/anaconda.pid


livemedia-creator --ks flat-nobara-live-official-39.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-39 --iso-only --iso-name Nobara-39-Official-$(date +%F).iso --releasever 39 --macboot

mv /var/lmc/*.iso .
rm -Rf /var/lmc/

livemedia-creator --ks flat-nobara-live-gnome-39.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-39 --iso-only --iso-name Nobara-39-GNOME-$(date +%F).iso --releasever 39 --macboot

mv /var/lmc/*.iso .
rm -Rf /var/lmc/

livemedia-creator --ks flat-nobara-live-kde-39.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-39 --iso-only --iso-name Nobara-39-KDE-$(date +%F).iso --releasever 39 --macboot

mv /var/lmc/*.iso .
rm -Rf /var/lmc/

livemedia-creator --ks flat-nobara-live-steamdeck-39.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-39 --iso-only --iso-name Nobara-39-SteamDeck-$(date +%F).iso --releasever 39 --macboot

mv /var/lmc/*.iso .
rm -Rf /var/lmc/

livemedia-creator --ks nv-flat-nobara-live-official-39.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-39 --iso-only --iso-name Nobara-39-Official-Nvidia-$(date +%F).iso --releasever 39 --macboot --extra-boot-args "modules_load=nvidia"

mv /var/lmc/*.iso .
rm -Rf /var/lmc/

livemedia-creator --ks nv-flat-nobara-live-gnome-39.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-39 --iso-only --iso-name Nobara-39-GNOME-Nvidia-$(date +%F).iso --releasever 39 --macboot --extra-boot-args "modules_load=nvidia"

mv /var/lmc/*.iso .
rm -Rf /var/lmc/

livemedia-creator --ks nv-flat-nobara-live-kde-39.ks --no-virt --resultdir /var/lmc --project Nobara --make-iso --volid Nobara-39 --iso-only --iso-name Nobara-39-KDE-Nvidia-$(date +%F).iso --releasever 39 --macboot --extra-boot-args "modules_load=nvidia"

mv /var/lmc/*.iso .
rm -Rf /var/lmc/

