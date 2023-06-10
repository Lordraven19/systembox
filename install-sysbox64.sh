clear
echo "SysBox"
echo "Run x86_64 apps on ARM!"
sleep 5
echo "Setup Process Initiating..."
sleep 3
echo "Updating Sources"
sleep 2.5
sudo apt-get update
echo "Installing Dependencies..."
sleep 2.5
sudo apt-get install qemu-user-static schroot debootstrap
echo "Setting up..."
sleep 2.5
debootstrap --arch amd64 --foreign testing /srv/chroot/debian-x86_64 http://deb.debian.org/debian
cp /usr/bin/qemu-x86_64-static /srv/chroot/debian-x86_64/usr/bin
chroot "/srv/chroot/debian-x86_64" /debootstrap/debootstrap --second-stage
echo "Creating the config file..."
sleep 2.5
sudo echo '[debian-x86_64]
description=Debian Testing x86_64 chroot
aliases=debian-x86_64
type=directory
directory=/srv/chroot/debian-x86_64
profile=desktop
personality=linux
preserve-environment=true' > /etc/schroot/chroot.d/debianx86_64.conf
sudo chmod 470 -R /etc/schroot/chroot.d/debianx86_64.conf
sleep 1
echo "Setup finished! Run sudo schroot -c debian-x86_64"
