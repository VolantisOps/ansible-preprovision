# Ansible Preprovision

This script will preprovision a fresh Archlinux ARM installation and get it ready for its first Ansible run.

## Instructions

1. Log into your new box as `alarm` with password `alarm`
2. Run `su - root` with password `root`
3. Run `curl -s https://github.com/bmcclure/ansible-preprovision/raw/10-root.sh | bash`
4. Run `reboot` and then log back in as the alarm user
5. Run `curl -s https://github.com/bmcclure/ansible-preprovision/raw/20-alarm.sh | bash`
