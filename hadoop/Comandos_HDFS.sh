# Format the filesystem:
bin/hdfs namenode -format

# Start NameNode daemon and DataNode daemon
sbin/start-dfs.sh

# Make the HDFS directories required to execute MapReduce jobs
bin/hdfs dfs -mkdir /user
bin/hdfs dfs -mkdir /user/<username>

# Show HDFS folder content
bin/hadoop fs -ls /user/root/wordcount/input/
  
# Copy the input files into the distributed filesystem:
bin/hdfs dfs -mkdir input
bin/hdfs dfs -put /data/hadoop/*.xml input

# Copy the output files from the distributed filesystem to the local filesystem and examine them
bin/hdfs dfs -get output output
# View the output files on the distributed filesystem:
bin/hdfs dfs -cat output/*

# When you’re done, stop the daemons with:
sbin/stop-dfs.sh

# Compile WordCount.java and create a jar:
bin/hadoop com.sun.tools.javac.Main /data/wordcount/WordCount.java
jar cf /data/wordcount/wc.jar /data/wordcount/WordCount*.class

# Run the application:
bin/hadoop jar wc.jar WordCount /user/joe/wordcount/input /user/joe/wordcount/output