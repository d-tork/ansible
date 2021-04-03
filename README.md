# Ansible Configurations

## Prep client
1. `PasswordAuthentication yes` must be set in `/etc/ssh/sshd_config` for the
central ansible user to copy its ssh key.

## Script order
1. `client_setup`
2. schedule cron to `ansible-pull`, or continue to run `ansible-playbook` from
server
3. add client ip(s) to server hosts (`/etc/ansible/hosts`)
4. run `ansible-playbook [playbook.yml]`

### Detailed instructions
On a new client:
```
wget https://raw.githubusercontent.com/d-tork/ansible/main/client_setup.sh
chmod +x client_setup.sh
sudo ./client_setup.sh
```
When prompted, enter the password for the new ansible user. 

When prompted, copy the generated command and log into the ansible host. Run
the pasted command which should resemble
```
ssh-copy-id -i ~/.ssh/id_rsa.pub 192.168.1.201
```

Return to the client, hit enter, wait for it to pull the local playbook from
this repo for the first time.

## To pull, from client
```
sudo su - ansible
ansible-pull -o -U https://github.com/d-tork/ansible.git
```

## To push, from host
First, ensure client ip is in `/etc/ansible/hosts`. Then
```
ansible-playbook [playbook.yml]
```
assuming playbook.yml has this:
```yaml
- hosts: all
```

### To push an 'all' playbook to a single host
```
ansible-playbook [playbook.yml] -i 192.168.1.201,
```
