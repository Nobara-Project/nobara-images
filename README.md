Set up mock build environment:
```
sudo mock -r ./nobara-44-x86_64.cfg --clean
sudo mock -r ./nobara-44-x86_64.cfg --install lorax-lmc-novirt vim-minimal pykickstart sbsigntools openssl kmod findutils grep gzip zstd xz
sudo cp ISO-ready-flattened-kickstarts/44/* /var/lib/mock/nobara-44-x86_64/root/builddir/
sudo cp -R lorax-custom lorax-default /var/lib/mock/nobara-44-x86_64/root/builddir/
sudo install -d -m 700 /var/lib/mock/nobara-44-x86_64/root/builddir/sb
sudo install -m 600 /path/to/nobara-sb.key /var/lib/mock/nobara-44-x86_64/root/builddir/sb/
sudo mock -r ./nobara-44-x86_64.cfg --shell --enable-network
```

From within mock environment, first point the kickstarts at the Secure Boot
signing key (see "Secure Boot" below):
```
# export NOBARA_SB_KEY=/builddir/sb/nobara-sb.key
```

Official:
```
# livemedia-creator --ks nv-flat-nobara-live-official-44.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-44 --iso-only --iso-name Nobara-44-Official-$(date +%F).iso --releasever 44 --macboot --extra-boot-args "modules_load=nvidia" --lorax-templates ./lorax-default
```

Gnome:
```
# livemedia-creator --ks nv-flat-nobara-live-gnome-44.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-44 --iso-only --iso-name Nobara-44-GNOME-$(date +%F).iso --releasever 44 --macboot --extra-boot-args "modules_load=nvidia" --lorax-templates ./lorax-default
```

KDE:
```
# livemedia-creator --ks nv-flat-nobara-live-kde-44.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-44 --iso-only --iso-name Nobara-44-KDE-$(date +%F).iso --releasever 44 --macboot --extra-boot-args "modules_load=nvidia" --lorax-templates ./lorax-default
```

Steam HTPC:
```
# livemedia-creator --ks nv-flat-nobara-live-steam-htpc-44.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-44 --iso-only --iso-name Nobara-44-Steam-HTPC-$(date +%F).iso --releasever 44 --macboot  --extra-boot-args "modules_load=nvidia" --lorax-templates ./lorax-custom
```
Steam Handheld:
```
livemedia-creator --ks nv-flat-nobara-live-steam-handheld-44.ks --no-virt --resultdir ./release --project Nobara --make-iso --volid Nobara-44 --iso-only --iso-name Nobara-44-Steam-Handheld-$(date +%F).iso --releasever 44 --macboot --extra-boot-args "modules_load=nvidia" --lorax-templates ./lorax-custom
```

exit

sudo mv /var/lib/mock/nobara-44-x86_64/root/builddir/release .
sudo rm -rf /var/lib/mock/nobara-44-x86_64/root/builddir/sb

Finished!

## Secure Boot

The ISOs boot with Secure Boot using Fedora's shim, Nobara's signed GRUB and
Nobara's signed kernel. Fedora's shim only trusts Nobara's GRUB once the Nobara
Secure Boot CA is enrolled, so on a computer that hasn't enrolled it yet:

1. Shim can't verify GRUB and opens a blue MokManager screen.
2. Choose **Enroll key from disk**, select the ISO's EFI partition, then
   `EFI` -> `BOOT` -> `ENROLL_THIS_KEY_IN_MOKMANAGER.der`.
3. Choose **Continue**, then **Yes**, then **Reboot**. The ISO now boots, and so
   does the installed system.

Each kickstart's `%post --nochroot` section runs on the build host, outside the
image, and fails the build unless:

- GRUB (installed and CD-boot) and every kernel are signed by the Nobara CA, and
  the kernels trust the Nobara signer for modules.
- `NOBARA_SB_KEY` (the Nobara signer key: a PEM file or a PKCS#11 URI) is set. It
  re-signs the modules DKMS built during compose (NVIDIA) with that key, which
  Nobara kernels trust without any enrolled key. `NOBARA_SB_CERT` defaults to
  the image's `/usr/share/nobara/eac/nobara-sb-signer.crt`.

It also deletes the DKMS and akmods signing keys created during compose, so each
installed system creates its own (`nobara-eac-enroll` enrolls them). The signing
key itself is never copied into the image; remove it from the mock root after
building, as above.

For a test ISO without the key, `export NOBARA_SB_ALLOW_UNSIGNED=1`; that ISO
does not boot with Secure Boot on. `build.sh` reads `NOBARA_SB_KEY` from
`./secureboot.env` (ignored by git) or the environment.

Note: instructions pulled from official Fedora documentation:

https://fedoraproject.org/wiki/Livemedia-creator-_How_to_create_and_use_a_Live_CD


