# Check the latest versions against imagestreams

In order to check, the latest versions are up2date also in imagestreams
we have ansible-playbook which checks it automatically.

## Prerequisities

In order to run this check install ansible-playbook by a command:

```bash
$ sudo dnf install -y ansible
```

## How to check the latest versions

For test run a command:
ansible-playbook check-imagestreams.yml

or simply by make command:
```bash
make check-latest-imagestreams
```

At the end of playbook you will see a message like
```bash
TASK [fail] ******************************************************************************************************************************************
fatal: [localhost]: FAILED! => {"changed": false, "msg": "Wrong imagestreams {'mariadb': '10.3', 'nginx': '1.16', 'perl': '5.26-mod_fcgid', 'python': '3.8', 'ruby': '2.6'}"}
```
in case the latest versions are not present in imagestreams.

In case all imagestreams are up2date and contains the latest versions a message will be:
```bash
TASK [fail] ******************************************************************************************************************************************
skipping: [localhost]
```

## Tested containers

Nowadays, we are able to check the latest version against imagestreams for these containers:
- httpd-container
- mariadb-container
- mysql-container
- nginx-container
- postgresql-container
- s2i-nodejs-container
- s2i-perl-container
- s2i-python-container
- s2i-ruby-container
