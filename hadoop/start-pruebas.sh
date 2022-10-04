#!/bin/bash
# The following instructions are to run a MapReduce job locally. If you want to execute a job on YARN, see YARN on Single Node.
export HADOOP_CLASSPATH=${JAVA_HOME}/lib/tools.jar
# Ruta donde hemos instalado Hadoop
cd /usr/local/hadoop
# Format the filesystem:
bin/hdfs namenode -format
# Start NameNode daemon and DataNode daemon. 
# The hadoop daemon log output is written to the $HADOOP_LOG_DIR directory (defaults to $HADOOP_HOME/logs).
# Browse the web interface for the NameNode; by default it is available at: http://localhost:9870/
# sbin/start-dfs.sh
# Make the HDFS directories required to execute MapReduce jobs:
bin/hdfs dfs -mkdir /user
bin/hdfs dfs -mkdir /user/root
# Copy the input files into the distributed filesystem
bin/hdfs dfs -mkdir input
# --> bin/hdfs dfs -put /local/<archivos> input
