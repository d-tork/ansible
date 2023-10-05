# Ansible Configurations

## Control node setup
The control node needs the following python packages installed via pip3: 
```
passlib
paramiko
ansible-lint
```

## First-time host setup
1. Add hostname of new server to the inventory file, ensuring it is in your `~/.ssh/config` and accessible with that config. You should definitely `ssh-copy-id` to it, even though it is accessible by password at this point. 
```ini
[presecurity]
new_server_alias
```
1. run the main playbook
```bash
ansible-playbook -l presecurity --skip-tags future main.yml
```

If successful, the server should not longer be accessble via ssh on port 22; update `~/.ssh/config` and move the server to another group in the inventory.

## Dev notes

* Mark in-progress/under construction tasks with the tag `future`. Then at execution, skip unfinished tasks with 
```bash
ansible-playbook --skip-tags "future" main.yml
```
