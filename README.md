# lain-jenkins-config

[![MIT license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://opensource.org/licenses/MIT)

Lain's layer 0 and layer 1 base image auto building  with jenkins

# 1. introduction

lain-jenkins-config is jenkins' job build config, which would build, tag and push images to your own registry

# 2. jenkins build step

2.1 install docker with version 1.11.1 or later

2.2 install [lain-cli](https://github.com/laincloud/lain-cli) && [lain-sdk](https://github.com/laincloud/lain-sdk)

2.3 lain config (private_docker_registry & domain) to your registry

2.4 install jenkins && run jenkins with **root**

2.5 install plugin of jenkins

2.6 restart jenkins


# 3 run jenkins with root user

3.1 edit jenkins config file

```
vi /etc/sysconfig/jenkins

$JENKINS_USER="root"
change others as you like, such as port, address etc.

```

3.2 change ownership of jenkins

```
chown -R root:root /var/lib/jenkins
chown -R root:root /var/cache/jenkins
chown -R root:root /var/log/jenkins
```

3.3 restart jenkins

```
service jenkins restart
```

