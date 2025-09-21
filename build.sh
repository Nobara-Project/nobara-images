#!/bin/bash

VERSION="42"
mkdir complete

livemedia-creator --ks ISO-ready-flattened-kickstarts/${VERSION}/flat-nobara-live-official-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-Official-$(date +%F).iso --releasever 42 --macboot
mv ./release/*.iso ./complete
rm -Rf ./release

livemedia-creator --ks ISO-ready-flattened-kickstarts/${VERSION}/flat-nobara-live-gnome-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-GNOME-$(date +%F).iso --releasever 42 --macboot
mv ./release/*.iso ./complete
rm -Rf ./release

livemedia-creator --ks ISO-ready-flattened-kickstarts/${VERSION}/flat-nobara-live-kde-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-KDE-$(date +%F).iso --releasever 42 --macboot
mv ./release/*.iso ./complete
rm -Rf ./release

livemedia-creator --ks ISO-ready-flattened-kickstarts/${VERSION}/flat-nobara-live-steam-htpc-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-Steam-HTPC-$(date +%F).iso --releasever 42 --macboot
mv ./release/*.iso ./complete
rm -Rf ./release

livemedia-creator --ks ISO-ready-flattened-kickstarts/${VERSION}/flat-nobara-live-steam-handheld-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-Steam-Handheld-$(date +%F).iso --releasever 42 --macboot
mv ./release/*.iso ./complete
rm -Rf ./release

livemedia-creator --ks ISO-ready-flattened-kickstarts/${VERSION}/nv-flat-nobara-live-official-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-Official-NV-$(date +%F).iso --releasever 42 --macboot --extra-boot-args "modules_load=nvidia"
mv ./release/*.iso ./complete
rm -Rf ./release

livemedia-creator --ks ISO-ready-flattened-kickstarts/${VERSION}/nv-flat-nobara-live-gnome-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-GNOME-NV-$(date +%F).iso --releasever 42 --macboot --extra-boot-args "modules_load=nvidia"
mv ./release/*.iso ./complete
rm -Rf ./release

livemedia-creator --ks ISO-ready-flattened-kickstarts/${VERSION}/nv-flat-nobara-live-kde-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-KDE-NV-$(date +%F).iso --releasever 42 --macboot --extra-boot-args "modules_load=nvidia"
mv ./release/*.iso ./complete
rm -Rf ./release

livemedia-creator --ks ISO-ready-flattened-kickstarts/${VERSION}/nv-flat-nobara-live-steam-htpc-42.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-42 --iso-only --iso-name Nobara-42-Steam-HTPC-NV-$(date +%F).iso --releasever 42 --macboot --extra-boot-args "modules_load=nvidia"
mv ./release/*.iso ./complete
rm -Rf ./release

chmod -R 777 ./complete
