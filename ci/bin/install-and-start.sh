#!/usr/bin/env bash
set -exuo pipefail

echo "=-=-=-=-=-=-=-=-=-="
echo "ECHO environment from inside install-and-start.sh"
printenv | sort
pwd
ls -lRa

echo "=-=-=-=-=-=-=-=-=-="
# echo "ECHO Bootstrap Pip"
# curl https://bootstrap.pypa.io/3.3/get-pip.py --output get-pip.py && python get-pip.py --user
# PATH=$PATH:$HOME/.local/bin
#pip3 install -r requirements --user

echo "=-=-=-=-=-=-=-=-=-="
echo "ECHO install pip3 via apt-get with sudo"
sudo apt-get install -y --no-install-recommends python3-pip

echo "=-=-=-=-=-=-=-=-=-="
echo "ECHO create venv, install dependencies"
pushd ${PKG_BASE_DIR}/${APPLICATION_NAME}
ls -lRa

python3 -m venv venv
./venv/bin/activate
python3 -m ensurepip --default-pip
./venv/bin/pip install --upgrade pip
./venv/bin/pip install -r requirements.txt
popd

echo "=-=-=-=-=-=-=-=-=-="
#echo "RUN apt-get update"
#sudo apt-get install -y --no-install-recommends python3-pip
#echo "=-=-=-=-=-=-=-=-=-="
#echo "Hail Mary"
# curl https://bootstrap.pypa.io/3.3/get-pip.py --output get-pip.py && python get-pip.py --user
# pushd .local/bin
# ./pip install -r requirements --user
# popd

#echo "RUN pip install"
#pip3 install -r requirements.txt
echo "=-=-=-=-=-=-=-=-=-="
echo "START buzzworthy webapp"
pushd ${PKG_BASE_DIR}/${APPLICATION_NAME}
python3 webapp.py
#python webapp.py

echo "=-=-=-=-=-=-=-=-=-="
