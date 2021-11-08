# fedora-livecd-kde.ks
#
# Description:
# - Fedora Live Spin with the K Desktop Environment (KDE), default 1.4 GB version
#
# Maintainer(s):
# - Sebastian Vahl <fedora@deadbabylon.de>
# - Fedora KDE SIG, http://fedoraproject.org/wiki/SIGs/KDE, kde@lists.fedoraproject.org

%include nobara-live-kde-base.ks
%include nobara-live-minimization.ks
%include nobara-kde-minimization.ks

# DVD payload
part / --size 25600

%post
%end

