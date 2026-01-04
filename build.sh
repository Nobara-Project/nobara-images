#!/bin/bash

VERSION="43"
mkdir complete

livemedia-creator --ks flat-nobara-live-official-43.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-43 --iso-only --iso-name Nobara-43-Official-$(date +%F).iso --releasever 43 --macboot
mv ./release/*.iso ./complete
rm -Rf ./release

livemedia-creator --ks flat-nobara-live-gnome-43.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-43 --iso-only --iso-name Nobara-43-GNOME-$(date +%F).iso --releasever 43 --macboot
mv ./release/*.iso ./complete
rm -Rf ./release

livemedia-creator --ks flat-nobara-live-kde-43.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-43 --iso-only --iso-name Nobara-43-KDE-$(date +%F).iso --releasever 43 --macboot
mv ./release/*.iso ./complete
rm -Rf ./release

livemedia-creator --ks flat-nobara-live-steam-htpc-43.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-43 --iso-only --iso-name Nobara-43-Steam-HTPC-$(date +%F).iso --releasever 43 --macboot
mv ./release/*.iso ./complete
rm -Rf ./release

livemedia-creator --ks flat-nobara-live-steam-handheld-43.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-43 --iso-only --iso-name Nobara-43-Steam-Handheld-$(date +%F).iso --releasever 43 --macboot
mv ./release/*.iso ./complete
rm -Rf ./release

livemedia-creator --ks nv-flat-nobara-live-official-43.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-43 --iso-only --iso-name Nobara-43-Official-NV-$(date +%F).iso --releasever 43 --macboot --extra-boot-args "modules_load=nvidia"
mv ./release/*.iso ./complete
rm -Rf ./release

livemedia-creator --ks nv-flat-nobara-live-gnome-43.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-43 --iso-only --iso-name Nobara-43-GNOME-NV-$(date +%F).iso --releasever 43 --macboot --extra-boot-args "modules_load=nvidia"
mv ./release/*.iso ./complete
rm -Rf ./release

livemedia-creator --ks nv-flat-nobara-live-kde-43.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-43 --iso-only --iso-name Nobara-43-KDE-NV-$(date +%F).iso --releasever 43 --macboot --extra-boot-args "modules_load=nvidia"
mv ./release/*.iso ./complete
rm -Rf ./release

livemedia-creator --ks nv-flat-nobara-live-steam-htpc-43.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-43 --iso-only --iso-name Nobara-43-Steam-HTPC-NV-$(date +%F).iso --releasever 43 --macboot --extra-boot-args "modules_load=nvidia"
mv ./release/*.iso ./complete
rm -Rf ./release

./sha256gen.sh
chmod -R 777 ./complete

