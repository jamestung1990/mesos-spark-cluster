#
FROM ubuntu:latest

#
MAINTAINER james.ch.tung@maxnerva.com

RUN apt-get -y update
RUN apt-get -y install git
RUN apt-get -y install openssh-server
RUN apt-get -y install vim
RUN apt-get -y install maven

RUN mkdir -p /opt/wisecloud
RUN mkdir /home/root
RUN cd /home/root
WORKDIR /home/root
RUN git clone https://github.com/jamestung1990/mesos-spark-cluster.git
RUN cd mesos-spark-cluster

ADD install-jdk.sh /home/root/install-jdk.sh
#RUN ./install-mesos.sh
#RUN ./install-spark.sh
#RUN ./install-cassandra.sh
ADD install-zookeeper.sh /home/root/install-zookeeper.sh

WORKDIR /home/root

RUN ./install-jdk.sh
RUN ./install-zookeeper.sh

CMD ["bash"]
