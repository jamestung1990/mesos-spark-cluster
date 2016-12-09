#!/bin/bash
#
# Runs Apache Mesos Master/Slave and (optionally) a demo/test framework
# Created: M. Massenzio, 2015-04-02

source `dirname $0`/common.sh

msg "Running Apache Mesos Master, Slave and Demo Framework (C++)"

if [[ ! -e "./build/bin/mesos-master.sh" ]]; then
    error "Could not find the mesos-master.sh script, are you in the top-level mesos repository?"
    exit 1
fi

cd build

# Creating the logging directory and the work directory
declare -r LOGS="/var/log/mesos"
declare -r WORKDIR="/var/lib/mesos"

for dir in $LOGS $WORKDIR ; do
    if [[ ! -d "$dir" ]]; then
        sudo mkdir -p $dir
        sudo chmod 2775 $dir
        sudo chown $USER:users $dir
    fi
done

# Clean up from previous sessions (will make the slave fail if there was a config change)
rm -f /tmp/mesos/meta/slaves/latest

msg "Starting the Master / Slave, logs in $LOGS, work dir $WORKDIR"
./bin/mesos-master.sh --ip=0.0.0.0 --work_dir=$WORKDIR \
    --log_dir=$LOGS >$LOGS/master.logs 2>&1 &
if [[ $? != 0 ]]; then
    error "Failed starting the Master"
    exit 1
fi
master_pid=$!
echo "$master_pid" >/tmp/MESOS_MASTER_PID

# Cleaning up in case of previous failed runs
rm -rf /tmp/mesos/slaves/

# Note the use of `hostname` here and below, instead of just 'localhost'; this is due to the fact
# that the Master tries to auto-resolve its hostname and (where DNS resolution is not enabled and
# it relies instead on /etc/hosts) this will cause mismatched servername between slave/master/framework
# (This seems particularly bad in Ubuntu, where the hostname is mapped in /etc/hosts to 127.0.1.1)
./bin/mesos-slave.sh --master=`hostname`:5050 > $LOGS/slave.logs 2>&1 &
if [[ $? != 0 ]]; then
    error "Failed starting the Slave"
    exit 1
fi
slave_pid=$!
echo "$slave_pid" >/tmp/MESOS_SLAVE_PID

msg "Master / Slave running in background in this session"
msg "Master PID: $master_pid"
msg "Slave PID: $slave_pid"
msg "To terminate use : kill \`cat /tmp/MESOS_MASTER_PID\` && kill \`cat /tmp/MESOS_SLAVE_PID\`"
echo
msg "Starting the test framework - check progress in the Web UI at http://localhost:5050"
msg "This should complete reasonably quickly, if it just hangs around, probably the slave exited"
msg "Check the slave logs in $LOGS/slave.logs (terminate this script with Ctrl-C)"

# TODO: we could actually start this in background, grab the PID, sleep for a while, then kill it
#       if it hasn't terminated yet (overkill?)
./src/test-framework --master=`hostname`:5050
