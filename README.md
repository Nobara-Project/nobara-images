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

The ISOs boot with Secure Boot using Fedora's shim and Nobara's signed GRUB and
kernels. Nobara signs with two CAs, and Fedora's shim only trusts what they sign
once they're enrolled as MOKs:

- Nobara EAC CA: GRUB and the Easy Anti-Cheat kernel (`kernel-eac`). Nothing
  boots with Secure Boot on until it's enrolled.
- Nobara Secure Boot CA: the normal kernel (`kernel`).

Both are on the ISO's EFI partition. On a computer that hasn't enrolled them
yet, no password is needed: MokManager only asks for one to confirm keys queued
from a running system (`mokutil --import`), not for keys enrolled from disk at
the console.

1. Shim can't verify GRUB ("Verification failed: (0x1A) Security Violation").
   Press a key; a blue MokManager screen opens.
2. Choose **Enroll key from disk**, select the ISO's EFI partition (listed as `ANACONDA`), then
   `EFI` -> `BOOT` -> `1_ENROLL_NOBARA_EAC_KEY.der`. Choose **Continue**, then
   **Yes**. MokManager returns to its menu.
3. Choose **Enroll key from disk** again and enroll
   `2_ENROLL_NOBARA_SECUREBOOT_KEY.der` the same way.
4. Choose **Reboot**. The ISO now boots, and so does the installed system, with
   either kernel. The keys are stored in the computer's firmware, not on a disk.

If the firmware refuses to start shim at all (no MokManager screen), its setup
may have Microsoft's third-party UEFI CA turned off, as some Lenovo
"Secured-core" and Surface devices ship. Turn on the option named like "Allow
Microsoft 3rd Party UEFI CA".

Each kickstart's `%post --nochroot` section runs on the build host, outside the
image, and fails the build unless:

- The image has an Easy Anti-Cheat kernel (`kernel-eac`). The ISO boots it
  (the lorax `x86.tmpl` picks it), so with Secure Boot on the ISO needs only the
  EAC CA; installs default to it once Secure Boot is on.
- GRUB (installed and CD-boot) and `kernel-eac` are signed by the Nobara EAC CA
  and the normal kernel by the Nobara Secure Boot CA, and each kernel trusts its
  own signer for modules.
- Every out-of-tree module of `kernel-eac` is signed by the Nobara EAC signer
  (they come from the `kmod-*-signed` packages), and when NVIDIA is in the image
  its signed build for `kernel-eac` is there. If `nvidia-signed-kmod-<kver>`
  lags behind the kernel in the repository, the build fails instead of making
  an ISO without NVIDIA on the EAC kernel.
- `NOBARA_SB_KEY` (the Nobara Secure Boot signer key: a PEM file or a PKCS#11
  URI) is set. It re-signs the modules DKMS built for the normal kernel during
  compose (NVIDIA) with that key, which the normal kernel trusts without any
  enrolled key. `NOBARA_SB_CERT` defaults to the image's
  `/usr/share/nobara/eac/nobara-sb-signer.crt`.

It also deletes the DKMS and akmods signing keys created during compose, so each
installed system creates its own (`nobara-eac-enroll` enrolls them). The signing
key itself is never copied into the image; remove it from the mock root after
building, as above.

For a test ISO without the key, `export NOBARA_SB_ALLOW_UNSIGNED=1`; that ISO
does not boot with Secure Boot on. `build.sh` reads `NOBARA_SB_KEY` from
`./secureboot.env` (ignored by git) or the environment.

Note: instructions pulled from official Fedora documentation:

https://fedoraproject.org/wiki/Livemedia-creator-_How_to_create_and_use_a_Live_CD


