#!/bin/bash
#
# Builds the Apache Mesos distribution
# Created: M. Massenzio, 2015-04-02

source `dirname $0`/common.sh

# Ensure apt-get is up to date.
sudo apt-get update && sudo apt-get -y upgrade

# Install build tools.
msg "Installing necessary dependencies, go grab a book: this WILL take time"
sudo apt-get -y install build-essential python-dev python-boto \
 libcurl4-nss-dev libsasl2-dev \
 maven libapr1-dev libsvn-dev
 

# Install OpenJDK java, only if needed
JAVAC=$(which javac)
if [[ -z $JAVAC ]]; then
    msg "Installing Open JDK 8"
    #sudo apt-get install -y openjdk-7-jdk
    ./install-jdk.sh
fi

# Check that we are in the right directory
if [[ ! -e bootstrap ]]; then
    error "This does not appear to be Mesos's top-level directory"
    error "This is the current directory: `pwd`"
    exit 1
fi

# Only needed for building from git cloned repo
if [[ -d .git ]]; then
     # Install autotoconf, automake and libtool
    sudo apt-get install -y autoconf libtool
    msg "Running the bootstrap script"
    wrap ./bootstrap
fi

# Configure and build.
msg "Building Mesos, this will take a long time..."
# TODO: should we run make clean first?
mkdir build
cd build
wrap ../configure
wrap make

# Run test suite.
msg "Testing build"
wrap make check

# Install (***Optional***).
msg "All tests passed; now installing to your system..."
wrap sudo make install

mesos_lib=$(echo $LD_LIBRARY_PATH | grep /usr/local/lib)
if [[ -z $mesos_lib ]]; then
    msg "Adding /usr/local/lib to LD_LIBRARY_PATH to .bashrc"
    echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/local/lib" >> ~/.bashrc
fi 
msg "Mesos install successful" "SUCCESS"
