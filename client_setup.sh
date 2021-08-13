#!/bin/bash

# Groundwork for Ansible clients
# 
# Assumes that openssh is installed and configured
# Adds user, sets permissions
# Run as sudo!

# Checks that user is sudoer
[[ $EUID -ne 0 ]] && echo "This script must be run as root." && exit 1

useradd -m -s /bin/bash -G sudo ansible 
echo "Set password for ansible user:"
passwd ansible
# TODO: pass perl-encrypted password hash to the useradd command
# 	since it remains the same across all clients
# https://www.cyberciti.biz/tips/howto-write-shell-script-to-add-user.html

# At this point, the orchestrator needs to copy its ansible ssh key to this
# client
# Show this computer's IP address and wait: 
# 	regex pattern is the first group of digits and periods
ip_addr=$(hostname -I | sed -r 's/^([[:digit:]\.]+)\s.*$/\1/')
echo -e "Log into Ansible central node and run the following:\n"
echo -e "\tssh-copy-id -i ~/.ssh/id_rsa.pub $ip_addr\n"
read -p 'Press enter once SSH key has been copied to client...'

# TODO: ensure PasswordAuthentication is set to yes in sshd_config
# Can this be done without entering a text editor? What if I just
#	echoed the line to be appended to the config file? 

# Configure sudo so ansible user can execute commands
echo 'ansible ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/ansible
chown root:root /etc/sudoers.d/ansible
chmod 440 /etc/sudoers.d/ansible

# Install ansible so that it can pull from git
DEBIAN_FRONTEND=noninteractive
apt-get -yq install ansible git ansible-pull

# Pull base playbook from github
runuser -u ansible -- ansible-pull -o -U https://github.com/d-tork/ansible.git

