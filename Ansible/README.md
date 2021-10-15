### Run command on the Ansible host [here](https://stackoverflow.com/questions/18900236/run-command-on-the-ansible-host)
Edit: You can avoid having to type connection: local in your play by adding this to your inventory:
```
localhost ansible_connection=local
```

### Create ansible role from scratch | Ansible roles example [here](https://www.golinuxcloud.com/create-ansible-role-with-example-playbooks/)