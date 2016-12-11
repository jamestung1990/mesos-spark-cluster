
wiseCloudDir=${1:-"/opt/wisecloud"}

zookeeperVersion=${2:-"3.4.9"}

if [ -f "zookeeper-$zookeeperVersion.tar.gz" ]
then
  wget http://ftp.tc.edu.tw/pub/Apache/zookeeper/stable/zookeeper-$zookeeperVersion.tar.gz
fi

tar zxvf zookeeper-$zookeeperVersion.tar.gz

mkdir -p "$wiseCloudDir"
mv zookeeper-$zookeeperVersion $wiseCloudDir

export ZOOKEEPER_HOME=$wiseCloud/zookeeper-$zookeeperVersion
echo "export ZOOKEEPER_HOME=$wiseCloud/zookeeper-$zookeeperVersion" >> ~/.profile
export PATH="$PATH:$ZOOKEEPER_HOME/bin"
echo "export PATH=\"$PATH:$ZOOKEEPER_HOME/bin\"" >> ~/.profile
