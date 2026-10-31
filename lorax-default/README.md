Stock lorax 44.7 `live` templates (`/usr/share/lorax/templates.d/99-generic/live`)
for the Official, GNOME and KDE ISOs. The only change is in `live/efi.tmpl`: the
Nobara Secure Boot CA is copied into the ISO's EFI partition so MokManager can
enroll it on first boot. `lorax-custom` (Steam editions) has the same change.
