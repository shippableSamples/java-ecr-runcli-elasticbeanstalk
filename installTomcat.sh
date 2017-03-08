
#! /bin/bash -e

########################################################################
#
# this assumes you have launched an Ubuntu server on Amazon EC/2
# and you have:
#  - added a Shippable user to the EC/2 node via the instructions
#    found at http://docs.shippable.com/integrations/deploy/nodeCluster/
#  - copied this script to the EC/2 instance
#  - connected via ssh with the 'ubuntu' user
#
# install multiple Tomcat instances on same EC/2 instance by passing 
# argument to the script, with different values provided for TOMCAT_DIR, e.g.
#   $ ./installTomcat.sh tomcat-prod tomcat-test
#
# if multiple Tomcat instances, installed, you'll need to change the
# default Tomcat ports for additional instances in $TOMCAT_DIR/conf/server.xml
#
########################################################################

# install Java if it isn't installed
if [ ! $(which java) ]; then
  sudo apt-get update
  sudo apt-get install default-jre
  export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
fi

# function that installs instance of Tomcat instance in /opt
function installTomcat() {
  TOMCAT_MAJOR="8"
  TOMCAT_VER="8.0.41"
  TOMCAT_DOWNLOAD="http://mirrors.gigenet.com/apache/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VER/bin/apache-tomcat-$TOMCAT_VER.zip"

  # create directory for tomcat
  cd /opt
  sudo mkdir $TOMCAT_DIR
  cd $TOMCAT_DIR

  # download and unzip tomcat, move files into TOMCAT_DIR
  sudo wget $TOMCAT_DOWNLOAD
  sudo apt-get update
  sudo apt-get install unzip
  sudo unzip apache-tomcat-$TOMCAT_VER.zip
  sudo mv apache-tomcat-$TOMCAT_VER/* .

  # create tomcat user/group
  if [[ ! $(getent group tomcat) ]]; then
    sudo groupadd tomcat
    sudo useradd -g tomcat -s /bin/bash -d /opt/tomcat-prod tomcat
  fi

  # create tomweb user/group
  if [[ ! $(getent group tomweb) ]]; then
    sudo groupadd tomweb
    sudo useradd -g tomweb -s /bin/bash -d /opt/tomcat-prod tomweb
  fi

  # ensure scripts are executable and folders are writeable
  sudo find /opt/$TOMCAT_DIR -type d -exec chmod 775 {} \;
  sudo chmod 755 /opt/$TOMCAT_DIR/bin/*.sh

  # make tomweb owner of the tomcat files/directories
  cd /opt
  sudo chown -R tomweb.tomweb /opt/$TOMCAT_DIR/

  # add the tomcat and shippable users to tomweb group
  sudo usermod -a -G tomweb tomcat
  if [[ $(getent passwd shippable) ]]; then
    sudo usermod -a -G tomweb shippable
  else
    echo "Shippable user created. See http://docs.shippable.com/integrations/deploy/nodeCluster/ for instructions."
  fi

  #        # switch to tomcat user and start server
  #        sudo su tomcat
  #        /opt/$TOMCAT_DIR/bin/startup.sh
  #        exit

}

# install Tomcat for all directories passed in as parameters
if [ $# -ne 0 ]; then
  for dir in "$@"; do
    export TOMCAT_DIR=$dir
    installTomcat
  done
else
  export TOMCAT_DIR=tomcat
  installTomcat
fi
