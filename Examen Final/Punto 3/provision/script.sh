#!/bin/bash

echo "Instalando Apache 2"
sudo apt update
sudo apt install apache2 -y

echo "Estado del servicio:"
sudo systemctl status apache2
