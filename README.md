# Ansible Configurations

## Script order
1. `client_setup`
2. schedule cron to `ansible-pull`, or continue to run `ansible-playbook` from
server
3. add client ip(s) to server hosts
4. run `ansible-playbook [playbook.yml]`

