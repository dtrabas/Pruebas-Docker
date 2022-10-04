# Fuente original: https://www.writecode.es/2019-02-25-cluster_hadoop_docker/

# Última versión LTS de Ubuntu (20.04)
FROM ubuntu:focal

# Instalamos un servidor SSH, la JDK8 y wget
RUN apt-get update && apt-get install -y openssh-server openjdk-8-jdk wget

# Ahora nos bajamos el software de Hadoop y lo dejamos en /usr/local/hadoop
RUN wget http://apache.rediris.es/hadoop/common/hadoop-2.10.1/hadoop-2.10.1.tar.gz && \
    tar -xzvf hadoop-2.10.1.tar.gz && \
    mv hadoop-2.10.1 /usr/local/hadoop && \
    rm hadoop-2.10.1.tar.gz
	
# Establecemos las variables de entorno
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HOME=/usr/local/hadoop
ENV PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin

# Creamos las claves ssh necesarias para que se comunique el nodo master 
# con los nodos slaves. Al tener todos las mismas claves e incluirlas como 
# claves autorizadas, el acceso ssh entre los distintos nodos está garantizado.
# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
	chmod 0600 ~/.ssh/authorized_keys
	
# Creamos los directorios para los namenodes, los datanodes y los logs de Hadoop
RUN mkdir -p ~/hdfs/namenode && \ 
    mkdir -p ~/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs

# Copiamos los ficheros de configuración y scripts que tenemos en el directorio
# config al directorio /tmp. De ahí los vamos moviendo cada uno a su ubicación final
COPY config/* /tmp/

RUN mv /tmp/ssh_config ~/.ssh/config && \
    mv /tmp/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \ 
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv /tmp/slaves $HADOOP_HOME/etc/hadoop/slaves && \
    mv /tmp/start-hadoop.sh ~/start-hadoop.sh

RUN chmod +x ~/start-hadoop.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh 
	
# Formateamos el sistema de ficheros de hadoop.
RUN /usr/local/hadoop/bin/hdfs namenode -format

# Como proceso de los contenedores configuramos el demonio de ssh. Así el nodo master
# podrá acceder a los nodos slave para arrancar los procesos de Hadoop necesarios para
# que formen parte del cluster.
CMD [ "sh", "-c", "service ssh start; bash"]

# Por último, dejamos abiertos unos cuantos puertos. En principio no son necesarios
# todos, pero los dejo así por si en un futuro los necesito

# Hdfs ports
EXPOSE 9000 50010 50020 50070 50075 50090
EXPOSE 9871 9870 9820 9869 9868 9867 9866 9865 9864
# Mapred ports
EXPOSE 19888
#Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088 8188
#Other ports
EXPOSE 49707 2122






