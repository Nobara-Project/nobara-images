#!/bin/bash

VERSION="44"

# Secure Boot: the kickstarts check the boot chain and sign the prebuilt kernel
# modules (NVIDIA) with the Nobara signer key from outside the image. Put
#   NOBARA_SB_KEY=/path/to/nobara-sb.key   (PEM file or PKCS#11 URI)
# in ./secureboot.env or the environment. NOBARA_SB_ALLOW_UNSIGNED=1 builds a
# test ISO that does not boot with Secure Boot.
[ -f ./secureboot.env ] && . ./secureboot.env
export NOBARA_SB_KEY NOBARA_SB_CERT NOBARA_SB_ALLOW_UNSIGNED
if [ -z "${NOBARA_SB_KEY:-}" ] && [ "${NOBARA_SB_ALLOW_UNSIGNED:-0}" != 1 ]; then
    echo "NOBARA_SB_KEY is not set (see ./secureboot.env); set NOBARA_SB_ALLOW_UNSIGNED=1 for a test ISO" >&2
    exit 1
fi
if ! command -v sbverify >/dev/null && [ "${NOBARA_SB_ALLOW_UNSIGNED:-0}" != 1 ]; then
    echo "sbverify is missing: dnf install sbsigntools" >&2
    exit 1
fi

mkdir complete

livemedia-creator --ks nv-flat-nobara-live-official-44.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-44 --iso-only --iso-name Nobara-44-Official-NV-$(date +%F).iso --releasever 44 --macboot --extra-boot-args "modules_load=nvidia" --lorax-templates ./lorax-default
mv ./release/*.iso ./complete
rm -Rf ./release

livemedia-creator --ks nv-flat-nobara-live-gnome-44.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-44 --iso-only --iso-name Nobara-44-GNOME-NV-$(date +%F).iso --releasever 44 --macboot --extra-boot-args "modules_load=nvidia" --lorax-templates ./lorax-default
mv ./release/*.iso ./complete
rm -Rf ./release

livemedia-creator --ks nv-flat-nobara-live-kde-44.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-44 --iso-only --iso-name Nobara-44-KDE-NV-$(date +%F).iso --releasever 44 --macboot --extra-boot-args "modules_load=nvidia" --lorax-templates ./lorax-default
mv ./release/*.iso ./complete
rm -Rf ./release

livemedia-creator --ks nv-flat-nobara-live-steam-htpc-44.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-44 --iso-only --iso-name Nobara-44-Steam-HTPC-NV-$(date +%F).iso --releasever 44 --macboot --extra-boot-args "modules_load=nvidia" --lorax-templates ./lorax-custom
mv ./release/*.iso ./complete
rm -Rf ./release

livemedia-creator --ks nv-flat-nobara-live-steam-handheld-44.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-44 --iso-only --iso-name Nobara-44-Steam-Handheld-$(date +%F).iso --releasever 44 --macboot --extra-boot-args "modules_load=nvidia" --lorax-templates ./lorax-custom
mv ./release/*.iso ./complete
rm -Rf ./release


./sha256gen.sh
chmod -R 777 ./complete

