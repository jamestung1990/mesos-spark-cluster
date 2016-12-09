#
FROM ubuntu:latest

#
MAINTAINER james.ch.tung@maxnerva.com

RUN apt-get update
RUN apt-get install git
RUN apt-get install openssh-server
RUN apt-get install vim
RUN apt-get install maven

RUN mkdir -p /opt/wisecloud/mesos-{version}
RUN cd
RUN git clone https://github.com/jamestung1990/mesos-spark-cluster.git
RUN cd mesos-spark-cluster

RUN ./install-jdk.sh
RUN ./install-mesos.sh
RUN ./install-spark.sh
RUN ./install-cassandra.sh
RUN ./install-zookeeper.sh
