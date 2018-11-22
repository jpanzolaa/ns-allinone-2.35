#!/bin/bash
######################################
# INSTALL NS-2 ON UBUNTU OR DEBIAN #
######################################

# |         THIS SCRIPT IS TESTED CORRECTLY ON         |
# |----------------------------------------------------|
# | OS             | ns235       | Test | Last test   |
# |----------------|-------------|------|-------------|
# | Ubuntu 18.04   | Ns 2.35     | OK   | 10 Julio 2018 |



# 1. KEEP UBUNTU OR DEBIAN UP TO DATE

sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo apt-get autoremove
sudo apt install gcc-4.8 g++-4.8
sudo apt-get install build-essential autoconf automake 
sudo apt-get install tcl8.5-dev tk8.5-dev
sudo apt-get install perl libxt-dev libx11-dev libxmu-dev xgraph
sudo apt install nam

# 2. INSTALL THE LIBRARY

sudo apt-get install -y git-all
git clone git://github.com/jpanzolaa/ns-allinone-2.35.git

cd ns-allinone-2.35
./install

ruta=$PWD

echo "# LD_LIBRARY_PATH" >> ~/.bashrc
echo "OTCL_LIB=$ruta/otcl-1.14/" >> ~/.bashrc
echo "NS2_LIB=$ruta/lib/" >> ~/.bashrc
echo "X11_LIB=/usr/X11R6/lib/" >> ~/.bashrc
echo "USR_LOCAL_LIB=/usr/local/lib/" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$OTCL_LIB:\$NS2_LIB:\$X11_LIB:\$USR_LOCAL_LIB" >> ~/.bashrc
echo "# TCL_LIBRARY" >> ~/.bashrc
echo "TCL_LIB=$ruta/tcl8.5.10/library/" >> ~/.bashrc
echo "USR_LIB=/usr/lib/" >> ~/.bashrc
echo "export TCL_LIBRARY=\$TCL_LIB:\$USR_LIB" >> ~/.bashrc
echo "# PATH" >> ~/.bashrc
echo "XGRAPH=$ruta/xgraph-12.2/:$ruta/bin/:$ruta/tcl8.5.10/unix/:$ruta/tk8.5.10/unix/" >> ~/.bashrc
echo "NS=$ruta/ns-2.35/" >> ~/.bashrc 
echo "NAM=$ruta/nam-1.15/" >> ~/.bashrc 
echo "PATH=\$PATH:\$XGRAPH:\$NS:\$NAM" >> ~/.bashrc

sleep 2

source ~/.bashrc

#cd ns-2.35
#./validate

echo "Instalacion Finalizada..."


