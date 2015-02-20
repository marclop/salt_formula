# salt_minion formula

Formula to set up the salt-minion. Made for the RHEL family exclusively

### Note

See the full [Salt Formulas installation and usage instructions](http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html)

Available states
================

- [salt_minion](#salt_minion)

``salt_minion``
------------
Installs the salt_minion from distribution packages, enables and starts the service by default. Additionally, sets the salt master if defined in pillar:
```
salt_minion:
  pkg: salt-minion
  service: salt-minion
  conf_path: /etc/salt/minion
  conf_include_dir: /etc/salt/minion.d
  version: 2014.7.1
  enabled: True
  master: salt.domain
```
