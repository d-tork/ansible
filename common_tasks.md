# Common Ansible tasks

## Update all machines that are ansible-ready

	ansible-playbook just_update.yml -l working

## Update single machine

	ansible-playbook just_update.yml -i bernard,

## Ping machines

	ansible bernard -m ping

	ansible working -m ping

## Send specific commands

	ansible working -a "cat /etc/os-release"

## Send special commands requiring 'become'

	ansible charlotte -a "shutdown +1" -b
