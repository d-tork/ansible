# Tasks

This is where Task List Files go (list-like of tasks only, not playbooks). Restrictions include:
- there should not be any `hosts:all` block
- `vars_files` not allowed, instead use `include_vars`
- `remote_user` not allowed; to specify, do it in whichever play imports this list
