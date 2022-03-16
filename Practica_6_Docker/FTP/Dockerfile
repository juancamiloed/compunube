FROM centos

MAINTAINER Juan Camilo

RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Linux-* &&\
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Linux-*

RUN yum upgrade -y

RUN useradd admin
RUN echo "admin:admin" | chpasswd

RUN yum install vsftpd -y

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf

EXPOSE 20 21

CMD ["/usr/sbin/vsftpd","-obackground=NO"]
