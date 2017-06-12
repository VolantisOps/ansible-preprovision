#!/bin/sh

hash=$(shasum /etc/ssl/certs/ca-certificates.crt | awk '{ print $1 }')

echo "Installing parted..."
pacman -Sy parted --noconfirm --needed

rootsize=$(df -hm | sed -n 2p | awk '{print $2}')
if [ $rootsize < 3000 ]; then
    echo "You must resize your disk now and then re-run this script:"
    echo "1. Run 'fdisk [device]'"
    echo "2. Use the options: d [Enter] n [Enter] [Enter] [Enter] [Enter] w"
    echo "3. Reboot or run partprobe"
    echo "4. Run 'resize2fs [partition]'"
    exit 1
fi

if [ $hash = "6aac3400f3ae5ed3bd736d71671c9e1ac1d379f1" ]; then
    echo "Deleting old ca-certificates.crt file before system upgrade..."
    rm -f /etc/ssl/certs/ca-certificates.crt
fi

echo "Installing system updates..."
pacman -Syu --noconfirm

echo "Installing sudo and setting up alarm user for sudo access..."
pacman -Sy sudo --noconfirm --needed
echo '%wheel ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/wheel
usermod -G wheel alarm

echo "What hostname would you like the server to have? "
read hostname

echo "Setting hostname..."
hostnamectl set-hostname $hostname

echo "Setting up SSH access for root"
mkdir -p /root/.ssh
chmod 700 /root/.ssh

echo "What is your GitHub username for pulling in authorized keys? "
read githubuser

echo "Installing authorized_keys..."
curl -o /root/.ssh/authorized_keys https://github.com/${githubuser}.keys
chmod 600 /root/.ssh/authorized_keys

echo "Installing python2..."
pacman -Sy python2 --noconfirm --needed

echo "Installing build prerequisites..."
pacman -Sy binutils make gcc fakeroot expac yajl git cower --noconfirm --needed

echo "You should reboot, and optionally set a static IP designation in your router now."
echo "Then, log in as the alarm user and run:"
echo "'curl -s https://raw.githubusercontent.com/bmcclure/ansible-preprovision/master/20-alarm.sh | bash'"
exit 0
