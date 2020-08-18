#!/usr/bin/env bash

echo "=-=-= START start.sh =-=-="

# echo "Installing the Consul agent config in the Consul agent data directory"
# cp -f ${APPLICATION_JOB_DIR}/config/${APPLICATION_NAME}-service-registry.json ${DATA_BASE_DIR}/consul/.
# chmod 744 ${DATA_BASE_DIR}/consul/${APPLICATION_NAME}-service-registry.json
#
# echo "Reload Consul to hook up with the Service configuration"
# export CONSUL_HTTP_SSL=true
# export CONSUL_CACERT="${TLS_CA_PATH}/${CONSUL_ENVIRONMENT}.cert.pem"
# export CONSUL_CLIENT_CERT="${TLS_CERTIFICATE}"
# export CONSUL_CLIENT_KEY="${TLS_PRIVATE_KEY}"
#
# ${PKG_BASE_DIR}/consul/bin/consul reload

echo "Where am I?"
pwd
ls -lRa

echo "List deployed packages under PKG_BASE_DIR"
pushd "${PKG_BASE_DIR}"
ls -lRa
popd

# echo "Exporting PATH and LD_LIBRARY_PATH for Python, assumes package was installed"
# for dir in $(ls -d /var/vcap/packages/*/bin); do export PATH=$dir:$PATH; done
# for dir in $(ls -d /var/vcap/packages/*/lib); do export LD_LIBRARY_PATH=$dir:${LD_LIBRARY_PATH:-}; done
# echo "Path after: $PATH"
# echo "LD path after: $LD_LIBRARY_PATH"

# echo "Exporting path where python was installed {PKG_BASE_DIR}"
# export PATH=$PATH:${PKG_BASE_DIR}/python/
# echo "Copying the python package into the APPLICATION_RUN_DIR directory as the packages directory cannot be modified at runtime, so pip install is failing with permissions error"
# cp -Rf ${PKG_BASE_DIR}/python ${APPLICATION_RUN_DIR}/.
# export PATH=$PATH:${APPLICATION_RUN_DIR}/python/bin/
# echo "Path after: $PATH"

# pushd ${APPLICATION_RUN_DIR}/python/bin/
# ls -lRa
# popd

echo "Where is Python?"
which python3

echo "Installing pip3"
wget https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user
export PATH=$PATH:~/.local/bin

echo "Where is Pip?"
which pip


# I feel like I shouldn't have to (re)install deps because the "install" done
# as part of "python" package should have done this... but should have also
# set the env variables... i thought!
# echo "Installing buzzworthy webapp"
# pushd ${PKG_BASE_DIR}/${APPLICATION_NAME}
# echo "Create Virutal Env"
# python3 venv venv
# source venv/bin/activate

pushd "${PKG_BASE_DIR}/${APPLICATION_NAME}"
echo "Directory listing"
ls -lRa

echo "Install deps"
pip install -r requirements.txt --user

echo "$PATH"
echo "Start webapp"
python3 webapp.py --user

echo "=-=-= END start.sh =-=-="
