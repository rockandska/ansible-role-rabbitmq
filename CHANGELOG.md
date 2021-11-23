# CHANGELOG

## [0.3.0](https://github.com/rockandska/ansible-role-rabbitmq/tree/0.3.0) (2021-11-23)

### feat

- add support for setting/deleting global parameters ([3add67f](https://github.com/rockandska/ansible-role-rabbitmq/commit/3add67f38a693ee5b807dbfefcf2896f43b69ab2))
- Add parameter support ([c776b94](https://github.com/rockandska/ansible-role-rabbitmq/commit/c776b94a66e2522f855bf458b5d5cd2b6f930f03))
- re-enable policies ([763628d](https://github.com/rockandska/ansible-role-rabbitmq/commit/763628db3321e4c64cd873d43f873f79d607793a))

### fix

- missing node parameter with delete policies ([1cd47f4](https://github.com/rockandska/ansible-role-rabbitmq/commit/1cd47f4f467548768818ad7e386ca219ecf7f0aa))

## [0.2.1](https://github.com/rockandska/ansible-role-rabbitmq/tree/0.2.1) (2021-11-22)

### fix

- don't gather facts for hosts not in the play ([7b249f9](https://github.com/rockandska/ansible-role-rabbitmq/commit/7b249f9b9ab617c69c59aab37dfe56ab1614f33b))

## [0.2.0](https://github.com/rockandska/ansible-role-rabbitmq/tree/0.2.0) (2021-11-21)

### feat

- add full ssl support (#25) ([14ca0c6](https://github.com/rockandska/ansible-role-rabbitmq/commit/14ca0c6d69faee524dd45928844870ac5fc58212))
- add ssl module args variables for management API ([b8a9560](https://github.com/rockandska/ansible-role-rabbitmq/commit/b8a9560f065e8fb11ed088a78986a8de1b19ff30))
- add possibility to add rabbimq user to group ([dbe62f6](https://github.com/rockandska/ansible-role-rabbitmq/commit/dbe62f647a808e4e07dbd03d184cccd642515dd0))
- add possibility to choose node name ([f467d12](https://github.com/rockandska/ansible-role-rabbitmq/commit/f467d1213a53448e3346c0794152fbc39c6079e0))
- add rabbitmq-env tpl ([99ef497](https://github.com/rockandska/ansible-role-rabbitmq/commit/99ef49778f9eaa2e6ade15c9a262b1ccf7028fca))

### fix

- add discovered inventory nodes to sysctl config ([7ee6752](https://github.com/rockandska/ansible-role-rabbitmq/commit/7ee67528485f1ef9ba176d30b81805d6f00772f8))
- pinning not respected ([972425f](https://github.com/rockandska/ansible-role-rabbitmq/commit/972425f18118e194f526f4df77b1f4ee0eb3184f))
- rabbitmq_internode_ssl -> rabbitmq_internode_ssl_config ([6463e56](https://github.com/rockandska/ansible-role-rabbitmq/commit/6463e56e1766472bb07324be171cd8094dd204ff))
- update README and plugins tasks ([26e14b4](https://github.com/rockandska/ansible-role-rabbitmq/commit/26e14b4639a2c998b9080e75aaa3ba89346914ca))
- enable plugins online ([652c452](https://github.com/rockandska/ansible-role-rabbitmq/commit/652c452c4a5aca8dda0f0ef1a15dd14e972e43be))

## [0.1.0](https://github.com/rockandska/ansible-role-rabbitmq/tree/0.1.0) (2020-07-01)
**Merged pull requests:**

- Fix/tests newrabbitmq [\#17](https://github.com/rockandska/ansible-role-rabbitmq/pull/17) ([rockandska](https://github.com/rockandska))
- switch to cloudsmitch repositories [\#20](https://github.com/rockandska/ansible-role-rabbitmq/pull/20) ([rockandska](https://github.com/rockandska))

**Deprecated**

RabbitMQ versions < 3.8 are not available anymore and could not be tested

## [0.0.7](https://github.com/rockandska/ansible-role-rabbitmq/tree/0.0.7) (2020-03-30)
**Closed issues:**

- Cookie creation [\#7](https://github.com/rockandska/ansible-role-rabbitmq/issues/7)

**Merged pull requests:**

- Fix CI/tests errors [\#12](https://github.com/rockandska/ansible-role-rabbitmq/pull/12) ([rockandska](https://github.com/rockandska))
- use no\_log var [\#11](https://github.com/rockandska/ansible-role-rabbitmq/pull/11) ([pad92](https://github.com/pad92))
- Fix enable systemd service with ansible 2.5 [\#10](https://github.com/rockandska/ansible-role-rabbitmq/pull/10) ([rockandska](https://github.com/rockandska))

## [0.0.6](https://github.com/rockandska/ansible-role-rabbitmq/tree/0.0.6) (2019-05-28)
**Merged pull requests:**

- \[cookie\] fix bash broken pipe \( fix \#7 \) [\#9](https://github.com/rockandska/ansible-role-rabbitmq/pull/9) ([rockandska](https://github.com/rockandska))
- \[pre\_checks\] remove test on variables type [\#8](https://github.com/rockandska/ansible-role-rabbitmq/pull/8) ([rockandska](https://github.com/rockandska))

## [0.0.5](https://github.com/rockandska/ansible-role-rabbitmq/tree/0.0.5) (2019-04-08)
**Merged pull requests:**

- Prevent service to start at install [\#6](https://github.com/rockandska/ansible-role-rabbitmq/pull/6) ([rockandska](https://github.com/rockandska))
- Fix pre\_check syntax [\#5](https://github.com/rockandska/ansible-role-rabbitmq/pull/5) ([rockandska](https://github.com/rockandska))

## [0.0.4](https://github.com/rockandska/ansible-role-rabbitmq/tree/0.0.4) (2019-03-19)
**Merged pull requests:**

- Optionnal disable/enable repository for yum [\#4](https://github.com/rockandska/ansible-role-rabbitmq/pull/4) ([rockandska](https://github.com/rockandska))

## [0.0.3](https://github.com/rockandska/ansible-role-rabbitmq/tree/0.0.3) (2019-03-18)
**Merged pull requests:**

- Fix cluster config [\#3](https://github.com/rockandska/ansible-role-rabbitmq/pull/3) ([rockandska](https://github.com/rockandska))
- Fix typo in repo/gpg url variable name [\#2](https://github.com/rockandska/ansible-role-rabbitmq/pull/2) ([rockandska](https://github.com/rockandska))

## [0.0.2](https://github.com/rockandska/ansible-role-rabbitmq/tree/0.0.2) (2019-02-21)
**Merged pull requests:**

- Fix cluster config [\#1](https://github.com/rockandska/ansible-role-rabbitmq/pull/1) ([rockandska](https://github.com/rockandska))

## [0.0.1](https://github.com/rockandska/ansible-role-rabbitmq/tree/0.0.1) (2019-02-20)


\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*
