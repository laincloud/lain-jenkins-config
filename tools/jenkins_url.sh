#!/bin/sh

set -e

echo '<?xml version='1.0' encoding='UTF-8'?>
<jenkins.model.JenkinsLocationConfiguration>
  <adminAddress>address not configured yet &lt;nobody@nowhere&gt;</adminAddress>
  <jenkinsUrl>http://0.0.0.0:8080/</jenkinsUrl>' \
> /var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml
exit