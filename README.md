ansible-role-rabbitmq
=========

Ansible role to install RabbitMQ from RabbitMQ repository.
Available on [Ansible Galaxy](https://galaxy.ansible.com/rockandska/rabbitmq)

**Ansible Galaxy :**
![Galaxy Score](https://img.shields.io/ansible/quality/38029.svg)

**Travis Build :**
[![Build Status](https://travis-ci.com/rockandska/ansible-role-rabbitmq.png?branch=master)](https://travis-ci.com/rockandska/ansible-role-rabbitmq)

Compatibility
------------

| **RabbitMQ**     |            |
| ---------------- | ---------- |
| 3.6.x            | Deprecated |
| 3.7.x            | Deprecated |
| 3.8              |     OK     |
| > 3.8            | Not tested |
| **Distribution** |            |
| CentOS 7         | OK         |
| CentOS > 7       | Not tested |
| Debian 9         | OK         |
| Debian > 9       | Not tested |
| Ubuntu bionic    | OK         |
| Ubuntu > bionic  | Not tested |

Requirements on remote hosts
------------

#### All distro

- [ansible-role-erlang](https://galaxy.ansible.com/rockandska/erlang) applied (**don't forget to use an erlang serie compatible with the rabbitmq version who will be installed. See [rabbitmq documentation](https://www.rabbitmq.com/which-erlang.html)**)
- socat
- logrotate
- python requests >= 1.0.0 ( if using bindings , exchanges, queues management provided by this role )
- For a cluster, hosts part of the cluster should be resolvable by their hostnames

#### Debian / Ubuntu

- apt-transport-https
- gpg-agent
- ca-certificates

#### CentOS / RedHat
- gnupg2

Role Variables
--------------

Defaults variables are inside `defaults/main.yml`
```yaml
---
###########
# Install #
###########
rabbitmq_series: 3.8
rabbitmq_series_rpm_version:
rabbitmq_series_deb_version:

rabbitmq_rpm_repo_url: https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-server/rpm/el
rabbitmq_rpm_gpg_url: https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-server/gpg.9F4587F226208342.key
rabbitmq_rpm_repo_tpl: etc/yum.repos.d/rabbitmq.repo.j2
rabbitmq_rpm_disable_repo:
rabbitmq_rpm_enable_repo:

rabbitmq_deb_repo_url: https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-server/deb
rabbitmq_deb_gpg_url: https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-server/gpg.9F4587F226208342.key
rabbitmq_deb_repo_tpl: etc/apt/sources.list.d/rabbitmq.list.j2
rabbitmq_deb_pinning_tpl: etc/apt/preferences.d/rabbitmq.j2

#################
# Custom Config #
#################
rabbitmq_vars_files: []

rabbitmq_sysctl_tpl: etc/rabbitmq/sysctl.conf.j2
rabbitmq_sysctl_config: {}

rabbitmq_erlang_tpl: etc/rabbitmq/erlang.config.j2
rabbitmq_erlang_config:

rabbitmq_env_tpl: etc/rabbitmq/rabbitmq-env.conf.j2
rabbitmq_env_config: {}

rabbitmq_node_name:

rabbitmq_systemd_override_tpl: etc/systemd/system/rabbitmq-server.service.d/override.conf.j2
rabbitmq_systemd_override: {}

rabbitmq_custom_logrotate_tpl: etc/logrotate.d/rabbitmq-server.j2
rabbitmq_custom_logrotate:

rabbitmq_users_groups: []

###########
# Cluster #
###########
rabbitmq_is_master:
rabbitmq_slave_of:
rabbitmq_peer_discovery_classic: true
rabbitmq_cluster_node_type: disc
rabbitmq_internode_ssl_config:

###########
# Plugins #
###########
rabbitmq_plugins_to_enable: []
rabbitmq_plugins_to_disable: []

#########
# Users #
#########
rabbitmq_users_to_create: []
rabbitmq_users_to_delete: []

############
# Api user #
############
rabbitmq_management_user:
rabbitmq_management_password:
rabbitmq_management_host:
rabbitmq_management_port:
rabbitmq_management_protocol:
rabbitmq_management_ca_cert:
rabbitmq_management_client_cert:
rabbitmq_management_client_key:

##########
# Vhosts #
##########
rabbitmq_vhosts_to_create: []
rabbitmq_vhosts_to_delete: []

##########
# Queues #
##########
rabbitmq_queues_to_create: []
rabbitmq_queues_to_delete: []

############
# Exchange #
############
rabbitmq_exchanges_to_create: []
rabbitmq_exchanges_to_delete: []

############
# Bindings #
############
rabbitmq_bindings_to_create: []
rabbitmq_bindings_to_delete: []

############
# Policies #
############
rabbitmq_policies_to_create: []
rabbitmq_policies_to_delete: []

##############
# Parameters #
##############
rabbitmq_parameters_to_create: []
rabbitmq_parameters_to_delete: []

#########
# Debug #
#########
rabbitmq_hide_log: true
```

#### Details

- `rabbitmq_series`

  - should be a float (3.8 available at 07.07.2021)

- `rabbitmq_rpm_repo_url`

  - repository base url used for the yum template

- `rabbitmq_rpm_gpg_url`

  - gpg key to used for the yum template

- `rabbitmq_rpm_repo_tpl`

  - path to the yum repository template
  - if you want to use your own template
    - add your template next to your playbook in `templates`
    - use a different path than the default one
    - keep the repository name as `rabbitmq`

- `rabbitmq_series_rpm_version`

  - install a specific version of the `rabbitmq_series` for the Centos / Redhat systems
  - example:
    ```
    3.8.11-1.el7
    3.8.10-1.el7
    3.8.9-1.el7
    3.8.8-1.el7
    ```

- `rabbitmq_rpm_disable_repo`

  - used if you want to use the capability to disable some repositories when installing rabbitmq

  - default: ""

  - example:

    ```
    rabbitmq_rpm_disable_repo: "*"
    ```

- `rabbitmq_rpm_enable_repo`

  - used if you want to use the capability to enable only some repositories in case you use `rabbitmq_rpm_disable_repo: "*"` when installing rabbitmq

  - default: ""

  - example:

    ```
    rabbitmq_rpm_enable_repo: "rabbitmq"
    ```

- `rabbitmq_deb_repo_url`

  - repository base url used for the apt template

- `rabbitmq_deb_gpg_url`

  - gpg key to used for the apt template

- `rabbitmq_deb_repo_tpl`

  - path to the apt repository template
  - if you want to use your own template
    - add your template next to your playbook in `templates`
    - use a different path than the default one

- `rabbitmq_deb_pinning_tpl`

  - path to the apt pinning template
  - if you want to use your own template
    - add your template next to your playbook in a `templates` directory
    - use a different path than the default one

- `rabbitmq_series_deb_version`

  - install a specific version of the `rabbitmq_series` for Debian systems
  - example:
    ```
    3.8.11-1
    3.8.10-1
    3.8.9-1
    3.8.8-1
    ```

- `rabbitmq_vars_files`

  - list of vars files used to override defaults variables if needed
  - if using relative path, put those files next to your playbook in `vars` directory
  - example:
    ```yaml
    rabbitmq_vars_files:
      - settings.yml
    ```

- `rabbitmq_sysctl_tpl`

  - path to the rabbitmq sysctl config template
  - only apply to versions >= 3.7 ([See RabbitMQ docs](https://www.rabbitmq.com/configure.html#configuration-files))
  - if you want to use your own template
    - add your template next to your playbook in a `templates` directory
    - use a different path than the default one

- `rabbit_systctl_config`

  - a dict representing the custom rabbitmq systctl config to apply
  - each dict level will be concatenate by a .
  - put specials variables between double quotes (example: "true")
  - examples:
    ```yaml
    rabbitmq_sysctl_config:
      listeners:
        tcp:
          default: 5673
      tcp_listen_options:
        linger:
          on: "true"
     # Will result into rabbitmq.conf as:
     # tcp_listen_options.linger.on = true
     # listeners.tcp.default = 5673
    ```

- `rabbitmq_erlang_tpl`

  - path to the rabbitmq erlang config template
  - if you want to use your own template
    - add your template next to your playbook in a `templates` directory
    - use a different path than the default one

- `rabbitmq_erlang_config`
  - a multiline string with the rabbitmq config in erlang format to apply
  - will be used as rabbitmq.config for version <=3.6
  - will be used as advanced.conf for version >=3.7
  - **don't enclose the configuration with `[` and `].` , it is done inside the template**
  - example:
  ```yaml
  rabbitmq_erlang_config: |
    {rabbit, [
        {tcp_listeners, [{"127.0.0.1", 5672}]}
      ]
    }
  ```

- `rabbitmq_env_tpl`
  - path to the rabbitmq env config template
  - if you want to use your own template
    - add your template next to your playbook in a `templates` directory
    - use a different path than the default one
  - some env vars are set automatically if SSL internodes is activated
    - ERL_SSL_PATH
    - SERVER_ADDITIONAL_ERL_ARGS
    - RABBITMQ_CTL_ERL_ARGS

- `rabbitmq_env_config`:
  - a dict representing the env config
  - the key should be the name of the environment variable
  - the value should be the content of the var
  - example:
    ```yaml
    rabbitmq_env_config:
      NODENAME: "bunny@myhost"
    ```

- `rabbitmq_node_name`:
  - a string representing the node name to use
  - use it if you change nodename through rabbitmq_env_config
  - example:
    ```yaml
    rabbitmq_node_name: "bunny@myhost"
    ```

- `rabbitmq_systemd_override_tpl`
  - path to the rabbitmq systemd override template
  - if you want to use your own template
    - add your template next to your playbook in a `templates` directory
    - use a different path than the default one

- `rabbitmq_systemd_override`
  - a dict representing the systemd override config
  - the first level is used for the ini section
  - the second level is used for the key / value
  - example:
    ```yaml
    rabbitmq_systemd_override:
      Service:
        LimitNOFILE: 30000
    # Will result into the systemd override file as:
    # [Service]
    # LimitNOFILE=30000
    ```

- `rabbitmq_custom_logrotate_tpl`
  - path to the rabbitmq custom logrotate template
  - if you want to use your own template
    - add your template next to your playbook in a `templates` directory
    - use a different path than the default one

- `rabbitmq_custom_logrotate`
  - a multiline string with the logrotate options for rabbitmq logs

  - will erase the default config

  - **/!\ Be aware that if you replace the default logrotate config by a custom one, the configuration applied will persist even if you unset this variable**

  - example:
    ```yaml
    rabbitmq_custom_logrotate: |
      weekly
      missingok
      rotate 40
      compress
      notifempty
    # Will result into the logrotate config file as:
    # /var/log/rabbitmq/*.log {
    #   weekly
    #   missingok
    #   rotate 40
    #   compress
    #   notifempty
    # }
    ```

- `rabbitmq_users_groups`

  - a list of users and user module arguments (name, groups,append)

  - Used to set/add user to groups after RabbitMQ installation

  - example:

    ```yaml
    rabbitmq_users_groups:
      - name: rabbitmq
        groups: ssl-cert
        append: true
    ```
  
- `rabbitmq_is_master`

  - true / false

  - tag the host as a master

  - not mandatory in standalone install

  - only use to know on which node the api calls and commands will be done and where to get the cookie to propagate.

  - Example:

    ```yaml
    rabbitmq_is_master: true
    ```

- `rabbitmq_slave_of`

  - inventory name of the master to join

  - tag the host as a slave

  - not mandatory in standalone install

  - **need to be a hostname/IP/alias who exist in the inventory**

  - Example:

    ```yaml
    rabbitmq_slave_of: rabbitmq-master.internal
    ```

- `rabbitmq_peer_discovery_classic`

  - default: true
  - the cluster configuration will be automatically generated and added to the configuration file based on inventory names (depends on `rabbitmq_is_master` , `rabbitmq_slave_of` role variable.)

- `rabbitmq_cluster_node_type`

  - default: disc
  - whether the node is of type `disc` or `ram`

- `rabbitmq_internode_ssl_config`
  - used to write dedicated internode configuration (see [RabbitMQ Documentation](https://www.rabbitmq.com/clustering-ssl.html#linux-strategy-two))
  - if set, the part who need to be added to `/etc/rabbitmq/rabbitmq-env.conf`
      will be done automatically.
  - Example:
    ```yaml
    rabbitmq_internode_ssl_config: |
      [
        {server, [
          {cacertfile, "/etc/ssl/private/Custom_Bundle-CA.pem"},
          {certfile,   "/usr/local/share/ca-certificates/{{ ansible_hostname }}.crt"},
          {keyfile,    "/etc/ssl/private/{{ ansible_hostname }}.key"},
          {secure_renegotiate, true}
        ]},
        {client, [
          {cacertfile, "/etc/ssl/private/Custom_Bundle-CA.pem"},
          {certfile,   "/usr/local/share/ca-certificates/{{ ansible_hostname }}.crt"},
          {keyfile,    "/etc/ssl/private/{{ ansible_hostname }}.key"},
          {secure_renegotiate, true}
        ]}
      ].
    ```

- `rabbitmq_users_to_create`

  - list of dict for users creation

  - refer to [ansible doc](https://docs.ansible.com/ansible/latest/modules/rabbitmq_user_module.html) for mandatory options and version compatibility

  - Example:

    ```yaml
    rabbitmq_users_to_create:
      - user: admin
        password: admin
        vhost: vhost_test
        configure_priv: .*
        read_priv: .*
        write_priv: .*
        tags: administrator
    ```

- `rabbitmq_users_to_delete`

  - list of users to delete

  - Example:

    ```yaml
    rabbitmq_users_to_delete:
      - guest
    ```

- `rabbitmq_management_user`

  - User used by rabbitmq_management plugin
  - Used if one or more of those configurations are set:
    - `rabbitmq_exchanges_to_create`
    - `rabbitmq_exchanges_to_delete`
    - `rabbitmq_bindings_to_create`
    - `rabbitmq_bindings_to_delete`
  - **Don't forget to configure rabbitmq_management to only allow connection from localhost if needed**

- `rabbitmq_management_password`

  - password for the user used by rabbitmq_management plugin

  - Used if one or more of those configurations are set:
    - `rabbitmq_exchanges_to_create`
    - `rabbitmq_exchanges_to_delete`
    - `rabbitmq_bindings_to_create`
    - `rabbitmq_bindings_to_delete`
  - **Don't forget to configure rabbitmq_management to only allow connection from localhost if needed**

- `rabbitmq_management_host`

  - default: localhost
  - Used if one or more of those configurations are set:
    - `rabbitmq_exchanges_to_create`
    - `rabbitmq_exchanges_to_delete`
    - `rabbitmq_bindings_to_create`
    - `rabbitmq_bindings_to_delete`
  - **Don't forget to configure rabbitmq_management to only allow connection from localhost if needed**

- `rabbitmq_management_port`

  - default: 15672
  - Used if one or more of those configurations are set:
    - `rabbitmq_exchanges_to_create`
    - `rabbitmq_exchanges_to_delete`
    - `rabbitmq_bindings_to_create`
    - `rabbitmq_bindings_to_delete`
  - **Don't forget to configure rabbitmq_management to only allow connection from localhost if needed**

- `rabbitmq_management_protocol`

  - default: http
  - Used if one or more of those configurations are set:
    - `rabbitmq_exchanges_to_create`
    - `rabbitmq_exchanges_to_delete`
    - `rabbitmq_bindings_to_create`
    - `rabbitmq_bindings_to_delete`
  - **Don't forget to configure rabbitmq_management to only allow connection from localhost if needed**

- `rabbitmq_management_ca_cert`

  - CA certificate to verify SSL connection to management API
  - Used if one or more of those configurations are set:
    - `rabbitmq_exchanges_to_create`
    - `rabbitmq_exchanges_to_delete`
    - `rabbitmq_bindings_to_create`
    - `rabbitmq_bindings_to_delete`
  - **Don't forget to configure rabbitmq_management to only allow connection from localhost if needed**

- `rabbitmq_management_client_cert`
  - Client certificate to send on SSL connections to management API.
  - Used if one or more of those configurations are set:
    - `rabbitmq_exchanges_to_create`
    - `rabbitmq_exchanges_to_delete`
    - `rabbitmq_bindings_to_create`
    - `rabbitmq_bindings_to_delete`
  - **Don't forget to configure rabbitmq_management to only allow connection from localhost if needed**

- `rabbitmq_management_client_key`
  - Private key matching the client certificate.
  - Used if one or more of those configurations are set:
    - `rabbitmq_exchanges_to_create`
    - `rabbitmq_exchanges_to_delete`
    - `rabbitmq_bindings_to_create`
    - `rabbitmq_bindings_to_delete`
  - **Don't forget to configure rabbitmq_management to only allow connection from localhost if needed**

- `rabbitmq_plugins_to_enable`

  - list of plugins to enable

  - example:

    ```yml
    rabbitmq_plugins_to_enable:
      - rabbitmq_management
      - rabbitmq_shovel
    ```

- `rabbitmq_plugins_to_disable`

  - list of plugins to disable

  - example:

    ```yml
    rabbitmq_plugins_to_disable:
      - rabbitmq_shovel
    ```

- `rabbitmq_vhosts_to_create`

  - list of dict for vhosts creation

  - refer to [ansible doc](https://docs.ansible.com/ansible/latest/modules/rabbitmq_vhost_module.html) for mandatory options and version compatibility

  - Example:

    ```yaml
    rabbitmq_vhosts_to_create:
      - name: vhost_test
        tracing: yes
    ```

- `rabbitmq_vhosts_to_delete`

  - list of vhost to delete

  - Example:

    ```yaml
    rabbitmq_vhosts_to_delete:
      - /
    ```

- `rabbitmq_queues_to_create`
  - list of queues to create
  - refer to [ansible doc](https://docs.ansible.com/ansible/latest/modules/rabbitmq_queue_module.html) for mandatory options and version compatibility
  - example:

    ```yaml
    rabbitmq_queues_to_create:
      - name: queue_test
        vhost: vhost_test
    ```

- `rabbitmq_queues_to_delete`
  - list of queues to delete

  - refer to [ansible doc](https://docs.ansible.com/ansible/latest/modules/rabbitmq_queue_module.html) for mandatory options and version compatibility

  - example:

    ```yaml
    rabbitmq_queues_to_delete:
      - name: queue_test
        vhost: vhost_test
    ```

- `rabbitmq_exchanges_to_create`

  - list of exchanges to create
  - refer to [ansible doc](https://docs.ansible.com/ansible/latest/modules/rabbitmq_exchange_module.html) for mandatory options and version compatibility
  - example:

    ```yaml
    rabbitmq_exchanges_to_create:
      - name: exchange_test
        vhost: vhost_test
    ```

- `rabbitmq_exchanges_to_delete`

  - list of exchanges to delete

  - refer to [ansible doc](https://docs.ansible.com/ansible/latest/modules/rabbitmq_exchange_module.html) for mandatory options and version compatibility

  - example:

    ```yaml
    rabbitmq_exchanges_to_delete:
      - name: exchange_test
        vhost: vhost_test
    ```

- `rabbitmq_bindings_to_create`

  - list of bindings to create

  - refer to [ansible doc](https://docs.ansible.com/ansible/latest/modules/rabbitmq_binding_module.html) for mandatory options and version compatibility

  - example:

    ```yaml
    rabbitmq_bindings_to_create:
      - name: exchange_test
        destination: queue_test
        destination_type: queue
        vhost: vhost_test
    ```

- `rabbitmq_bindings_to_delete`

  - list of bindings to delete

  - refer to [ansible doc](https://docs.ansible.com/ansible/latest/modules/rabbitmq_binding_module.html) for mandatory options and version compatibility

  - example:

    ```yaml
    rabbitmq_bindings_to_delete:
      - name: exchange_test
        destination: queue_test
        destination_type: queue
        vhost: vhost_test
    ```

- `rabbitmq_policies_to_create`

  - list of policies to create

  - refer to [ansible doc](https://docs.ansible.com/ansible/latest/modules/rabbitmq_policy_module.html) for mandatory options and version compatibility

  - example:

    ```yaml
     rabbitmq_policies_to_create:
       - name: HA
         vhost: vhost_test
         pattern: .*
         tags:
           ha-mode: all
    ```

- `rabbitmq_policies_to_delete`

  - list of policies to delete

  - refer to [ansible doc](https://docs.ansible.com/ansible/latest/modules/rabbitmq_policy_module.html) for mandatory options and version compatibility

  - example:

    ```yaml
    rabbitmq_policies_to_delete:
      - name: HA
        vhost: vhost_test
    ```

- `rabbitmq_parameters_to_create`

  - list of parameters to create

  - refer to [ansible doc](https://docs.ansible.com/ansible/latest/modules/rabbitmq_parameter_module.html) for mandatory options and version compatibility

  - `value` will be converted to json in the task

  - example:

    ```yaml
     rabbitmq_parameters_to_create:
       - name: federation-test
         component: federation-upstream
         value:
           uri: amqp://admin:admin@localhost
           prefetch-count: 1
         vhost: vhost_test
    ```

- `rabbitmq_parameters_to_delete`

  - list of parameters to delete

  - refer to [ansible doc](https://docs.ansible.com/ansible/latest/modules/rabbitmq_parameter_module.html) for mandatory options and version compatibility

  - example:

    ```yaml
    rabbitmq_parameters_to_delete:
      - component: federation
        name: local-username
    ```

- `rabbitmq_hide_log`

  - default: true
  - don't show the log for api calls to avoid leaking of sensitive information
  - set to false for debug

Example Playbook
----------------

#### Standalone

```yaml
- hosts: rabbitmq
  roles:
    - rockandska.erlang
    - rockandska.rabbitmq
```

#### Cluster

Since it is require to have the master node started before getting the slaves joining, do the cluster deployment in two steps.

```yaml
- hosts: rabbitmq-master
  roles:
    - role: rockandska.erlang
    - role: rockandska.rabbitmq
      vars:
        rabbitmq_is_master: true

- hosts: rabbitmq-slave
  roles:
    - role: rockandska.erlang
    - role: rockandska.rabbitmq
      vars:
        rabbitmq_slave_of: rabbitmq-master
```



Local Testing
-------------

#### Requirements

python3 <3.8
docker

#### Run tests

```sh
$ make test
```

After a first run, additional targets for each tox env / molecule scenario should be available
through auto-completion.

To debug and run a custom molecule command on custom environment with only default test scenario:
```sh
$ source tmp/bin/activate
$ tox -e py3-ansible27 -- molecule test -s default
```
For more information about molecule go to their [docs](http://molecule.readthedocs.io/en/latest/).

If you would like to run tests on remote docker host just specify `DOCKER_HOST` variable before running tox tests.

License
-------

BSD
