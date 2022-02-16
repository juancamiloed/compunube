#!/bin/bash

cat <<TEST> /etc/resolv.conf
nameserver 8.8.8.8
TEST

echo "Instalando LXD"
sudo apt-get install lxd -y

echo "Login en nuevo grupo lxd"
newgrp lxd
lxd init --auto

echo "Creando contenedor Web"
lxc launch ubuntu:20.04 web

echo "Instalando apache en el contenedor"
lxc exec web -- apt-get install apache2 -y

echo "Creando archivo index.html"
sudo echo "<html>
<html>
<body>
<h1>Pagina de prueba</h1>
<p>Bienvenidos a mi contenedor LXD</p>
</body>
</html>" > ./index.html

echo "Remplazando index.html en el contenedor"
lxc file push index.html web/var/www/html/index.html

echo "Verificando contenido de archivo index.html"
lxc exec web -- cat /var/www/html/index.html

echo "Reiniciando el servicio"
lxc exec web -- systemctl restart apache2

echo "Reenvio de puertos"
lxc config device add web myport80 proxy listen=tcp:192.168.100.25:5080 connect=tcp:127.0.0.1:80
