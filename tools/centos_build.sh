#!/bin/sh

set -e

# make sure in root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

yum update -y

# install docker and start docker
curl -fsSL https://get.docker.com/ | sh
systemctl enable docker
service docker start

yum install -y gcc python-devel python-pip

# install lain-sdk and lain-cli
if [[ ! -x "lain-sdk" ]]; then
    git clone --depth=1 https://github.com/laincloud/lain-sdk.git
fi
if [[ ! -x "lain-cli" ]]; then
    git clone --depth=1 https://github.com/laincloud/lain-cli.git
fi
cd lain-sdk && python setup.py install
cd ..
cd lain-cli && python setup.py install
cd ..
rm -rf lain-sdk
rm -rf lain-cli

# config private_docker_registry and domain dev
lain config save-global private_docker_registry ${PRIVATE_DOCKER_REGISTRY}
lain config save dev domain ${REGISTRY}

# install jenkins 2.2
sudo wget http://pkg.jenkins-ci.org/redhat/jenkins-2.2-1.1.noarch.rpm
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum localinstall -y jenkins-2.2-1.1.noarch.rpm

# change jenkins to root
sed -i 's/JENKINS_USER=\"jenkins\"/JENKINS_USER=\"root\"/g' /etc/sysconfig/jenkins
chown -R root:root /var/lib/jenkins
chown -R root:root /var/cache/jenkins
chown -R root:root /var/log/jenkins

# start jenkins
systemctl enable jenkins
service jenkins start

# install python libs
pip install -r pip_req.txt

exit 0