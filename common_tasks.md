# Common Ansible tasks

## Update all linux servers

	ansible-playbook playbooks/software_updates.yml -l linux

## Update single machine

	ansible-playbook playbooks/software_updates.yml -i dolores,

## Ping machines

	ansible dolores -m ping

	ansible linux -m ping

## Send specific commands

	ansible dolores -a "cat /etc/os-release"

## Send special commands requiring 'become'

	ansible dolores -a "shutdown +1" -b
