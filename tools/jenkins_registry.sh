#!/bin/sh

set -e

registry=$1
registry=${registry//\//\\\/}

find . -name '*.xml'| xargs -I{} sed -i -r 's/^export REGISTRY=(.)*/export REGISTRY='$registry'/g' {}

exit