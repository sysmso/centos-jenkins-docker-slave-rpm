FROM centos:latest
MAINTAINER Martin Souchal <souchal@apc.in2p3.fr>


RUN yum install -y openssh-server git unzip zip lsof java-1.8.0-openjdk-headless rpmdevtools yum-utils build-essentials && yum clean all

RUN yum group install -y "Development Tools" 

RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd \
    && mkdir -p /var/run/sshd \
    && useradd -u 1000 -m -s /bin/bash jenkins \
    && echo "jenkins:jenkins" | chpasswd \
    && /usr/bin/ssh-keygen -A \
    && echo export JAVA_HOME="/`alternatives  --display java | grep best | cut -d "/" -f 2-6`" >> /etc/environment


EXPOSE 22 
CMD ["/usr/sbin/sshd", "-D"]
