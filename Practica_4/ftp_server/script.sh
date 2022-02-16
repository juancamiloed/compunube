#!/bin/bash

cat <<TEST> /etc/resolv.conf
nameserver 8.8.8.8
TEST

echo "Instalando un servidor vsftpd"
sudo apt-get install vsftpd -y

echo “Modificando vsftpd.conf con sed”
sed -i 's/#write_enable=YES/write_enable=YES/g' /etc/vsftpd.conf
sed -i 's/#ftpd_banner=Welcome to blah FTP service./ftpd_banner=Bienvenido al servidor FTP/g' /etc/vsftpd.conf

sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf

echo "Creando nuevo usuario"
sudo useradd -m ftpuser
