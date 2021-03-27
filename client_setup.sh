#!/bin/bash

# Groundwork for Ansible clients
# 
# Assumes that openssh is installed and configured
# Adds user, sets permissions
# Run as sudo!

# Checks that user is sudoer
[[ $EUID -ne 0 ]] && echo "This script must be run as root." && exit 1


useradd -d /home/ansible -m ansible
passwd ansible
usermod -aG sudo ansible

# At this point, the orchestrator needs to copy its ansible ssh key to this
# client
# Show this computer's IP address and wait: 
# regex pattern is the first group of digits and periods
ip_addr=$(hostname -I | sed -r 's/^([[:digit:]\.]+)\s.*$/\1/')
echo "This client's ip: $ip_addr"
read -p 'Press enter once SSH key has been copied to client...'

# TODO: ensure PasswordAuthentication is set to yes in sshd_config
# Can this be done without entering a text editor? What if I just
# echoed the line to be appended to the config file? 

# Configure sudo so ansible user can execute commands
echo 'ansible ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/ansible
chown root:root /etc/sudoers.d/ansible
chmod 440 /etc/sudoers.d/ansible
