#!/bin/bash


# Build image containing a golang based word emitter

# @author  Fabrice Jammes

set -euxo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

. $DIR/conf.sh

usage() {
  cat << EOD

Usage: `basename $0` [options]

  Available options:
    -h          this message

Build image containing a golang based word emitter
EOD
}

# get the options
while getopts h c ; do
    case $c in
	    h) usage ; exit 0 ;;
	    \?) usage ; exit 2 ;;
    esac
done
shift `expr $OPTIND - 1`

# This command avoid retrieving build dependencies if not needed
$(ciux get image --check $DIR --env)

if [ $CIUX_BUILD = false ];
then
    echo "Build cancelled, image $CIUX_IMAGE_URL already exists and contains current source code"
    exit 0
fi

ciux ignite --selector build $DIR
. $CIUXCONFIG

# Build image
docker image build --tag "$CIUX_IMAGE_URL" "$DIR"

echo "Build successful"

