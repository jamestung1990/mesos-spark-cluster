==========================
Apache Mesos Build scripts
==========================

The `Getting started`_ instructions are a good start (no surprise there!) but are somewhat incomplete and currently look a bit outdated (I plan to fix them soon): however, the outcome has been that I have struggled more than I felt necessary in building and running Mesos on a dev VM (Ubuntu 14.04 running under VirtualBox).

Some of the issue seem to arise from the unfortunate combination of Mesos Master trying to guess its own IP address, the VM being (obviously) non-DNS resolvable and, eventually, the Slave and the Framework failing to properly communicate with the Master.

In the process of solving this, I ended up automating all the dependencies installation, building and running the framework; I have then broken it down into the following modules to make it easier to run only parts of the process.

Installation
------------

There are two ways of obtaining an Apache Mesos distribution: either via a tarball, or cloning the repo_; either are supported, but will require running the scripts differently: they should all be copied inside the same directory (eg ``/home/user/scripts``) and run from there.

Obviously, make them executable via ``chmod a+x /home/user/scripts/{build,install,run}-mesos.sh``

This has been tested both on a VM and a physical box, both running Ubuntu 14.04.

Running
-------

If you want to download and install from the tarball, execute::

    /path/to/script/install-mesos.sh

optionally followed by the version number (eg, ``0.23.0``): it currently defaults to ``0.22.0``.

If you have already cloned the git repo_, just run::

    /path/to/script/build-mesos.sh

optionally followed by::

    /path/to/script/run-mesos.sh

**NOTE** As these scripts need to ``cd`` in the correct directories, due to the expansion of ``dirname $0``, this will fail unless it's run with an absolute path (as shown above) or using shell expansion wildcards (eg ``~``).  

*Running it like ``./my_scripts/mesos-install.sh`` will most likely fail.*

.. _repo: https://github.com/mesosphere/mesos
.. _Getting started: http://mesos.apache.org/gettingstarted/