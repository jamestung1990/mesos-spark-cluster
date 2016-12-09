#!/bin/bash

# Created: M. Massenzio, 2015-04-02

source `dirname $0`/common.sh
declare -r VERSION=${1:-"0.22.0"}

# Get Mesos - update the $VERSION if you need a more recent release
declare -r dir="${HOME}/mesos-dev"
msg "Getting Mesos $VERSION and unpacking to $dir"
mkdir -p $dir
cd $dir

msg "Downloading Apache Mesos ($VERSION)"
wget http://www.apache.org/dist/mesos/$VERSION/mesos-$VERSION.tar.gz
if [[ ! -e "mesos-$VERSION.tar.gz" ]]; then
    error "Failed to download Mesos distribution: mesos-$VERSION.tar.gz"
    exit 1
fi
tar -zxf mesos-$VERSION.tar.gz

# Change working directory (the actual name will depend on Mesos version no.)
cd $dir/mesos-$VERSION

# Running the build script
msg "Running the Build script"
wrap `dirname $0`/build-mesos.sh


read -p "Do you want to run a test framework (y/n)? " choice
if [[ $choice == 'y' ]]; then
    `dirname $0`/run-mesos.sh
fi
