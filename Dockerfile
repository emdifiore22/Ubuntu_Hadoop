# Dockerfile per la creazione di un'immagine ubuntu contenente:
# 1. ssh
# 2. pdsh
# 3. vim
# 4. deafult-jdk
# 5. wget
# 6. hadoop 2.10.0

FROM ubuntu:latest

# Installazione pacchetti
RUN apt-get update && apt-get install -y ssh pdsh vim default-jdk wget

# Generazione chiavi SSH e copia del file di start (SSH e start_all.sh)
COPY start.sh /start.sh
RUN chmod 777 start.sh
RUN ssh-keygen -t rsa -P "" -f "/root/.ssh/id_rsa"
RUN cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys

# Creazione cartelle hadoop
RUN mkdir opt/hadoop/
RUN mkdir opt/hadoop/hadoop/
COPY hadoop-2.10.0/* /opt/hadoop/hadoop/

#Creazione variabile d'ambiente
ENV HADOOP_HOME=/opt/hadoop/hadoop

# Start hadoop
RUN ./opt/hadoop/hadoop/bin/hadoop namenode -format

