#!/bin/sh

read -p "What hostname would you like the server to have? " hostname </dev/tty

echo "Setting hostname..."
hostnamectl set-hostname $hostname

echo "Setting up SSH access for root"
mkdir -p /root/.ssh
chmod 700 /root/.ssh

read -p "What is your GitHub username for pulling in authorized keys? " githubuser </dev/tty

echo "Installing authorized_keys..."
curl -o /root/.ssh/authorized_keys https://github.com/${githubuser}.keys
chmod 600 /root/.ssh/authorized_keys

echo "Installing python2..."
pacman -Sy python2 --noconfirm --needed

echo "You should now be ready to finish provisioning with Ansible."
exit 0
