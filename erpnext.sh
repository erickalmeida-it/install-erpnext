#!/bin/bash
# Descrição: ERPNEXT INSTALL
# Criado por: Erick Almeida
# Data de Criacao: 24/08/2020
# Ultima Modificacao: 26/08/2020
# Compativél com o Ubuntu 18.04 (Homologado)

echo -e "\e[01;31m                 SCRIPT DE INSTALAÇÃO PARA O ERPNEXT - INTERATIVO - UBUNTU SERVER 18.04     \e[00m"
echo -e "\e[01;31m                                       Tecle <ENTER> para iniciar...                       \e[00m"
read #pausa até que o ENTER seja pressionado

# ATUALIZAR REPOSITÓRIOS,PACOTES E A DISTRIBUIÇÃO DO SISTEMA OPERACIONAL

echo -e "\e[01;31m                  ATUALIZANDO PACOTES,REPOSITÓRIOS E A DISTRIBUIÇÃO DO SISTEMA OPERACIONAL                                \e[00m"
echo -e "\e[01;31m                                       Tecle <ENTER> para continuar...                       \e[00m"
read #pausa até que o ENTER seja pressionado

apt update -y
apt upgrade -y
apt dist-upgrade -y

# INSTALAR DE DEPENDENCIAS INICIAIS

echo -e "\e[01;31m                                     INSTALANDO DEPENDENCIAS INICIAIS                                 \e[00m"
echo -e "\e[01;31m                                       Tecle <ENTER> para continuar...                       \e[00m"
read #pausa até que o ENTER seja pressionado

apt install python3-minimal build-essential python3-setuptools locales-all zip -y

# AJUSTAR LIGUAGEM UTF 

echo -e "\e[01;31m                                           AJUSTANDO LIGUAGEM UTF                               \e[00m"
echo -e "\e[01;31m                                       Tecle <ENTER> para continuar...                       \e[00m"
read #pausa até que o ENTER seja pressionado


export LC_ALL=C.UTF-8

# BAIXAR O SCRIPT DO DESEVOLVEDOR (EM PYTHON) 

echo -e "\e[01;31m                                BAIXANDO O SCRIPT DO DESEVOLVEDOR (EM PYTHON)                               \e[00m"
echo -e "\e[01;31m                                       Tecle <ENTER> para continuar...                       \e[00m"
read #pausa até que o ENTER seja pressionado

wget https://raw.githubusercontent.com/frappe/bench/develop/install.py

# INSTALAR O ERPNEXT   

echo -e "\e[01;31m                                           INSTALANDO O ERPNEXT                          \e[00m"
echo -e "\e[01;31m                                       Tecle <ENTER> para continuar...                       \e[00m"
read #pausa até que o ENTER seja pressionado

python3 install.py --production


# AJUSTAR OS PERMISSIONAMENTOS DE ESCRITA E INICIANDO O SERVIÇO   

echo -e "\e[01;31m                      AJUSTANDO OS PERMISSIONAMENTOS DE ESCRITA E INICIANDO O SERVIÇO                            \e[00m"
echo -e "\e[01;31m                                       Tecle <ENTER> para continuar...                       \e[00m"
read #pausa até que o ENTER seja pressionado

chmod -R 777 /home/frappe/.ansible/tmp
cd /home/frappe/frappe-bench/
sudo -H -u frappe bash -c "bench start"

echo -e "\e[01;31m                                    ALTERANDO PORTA HTTP VIA ACESSO WEB                           \e[00m"
echo -e "\e[01;31m                                       Tecle <ENTER> para continuar...                       \e[00m"
read #pausa até que o ENTER seja pressionado

sed -i 's/listen 80;/listen 71;/g' /home/frappe/frappe-bench/config/nginx.conf

sudo systemctl restart nginx

# EFETUADO AJUSTE DE FIREWALL

echo -e "\e[01;31m                                            AJUSTANDO FIREWALL                          \e[00m"
echo -e "\e[01;31m                                       Tecle <ENTER> para continuar...                       \e[00m"
read #pausa até que o ENTER seja pressionado

systemctl enable ufw
ufw allow 22
ufw allow 80
ufw allow 443
ufw allow 71

echo -e "\e[01;31m                 A INSTALAÇÃO SUCEDEU BEM, SEU SERVIDOR SERÁ REINICIADO E PODERÁS UTILIZAR O ERPNEXT     \e[00m"
echo -e "\e[01;31m                                     EM SEU NAVEGADOR ACESSE http://IPDOSEUSERVIDOR:71     \e[00m"
echo -e "\e[01;31m                                           Tecle <ENTER> para encerrar...                       \e[00m"
read #pausa até que o ENTER seja pressionado
reboot