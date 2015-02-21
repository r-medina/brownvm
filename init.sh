#!/bin/bash

set -e

echo "apt-get update..."
sudo apt-get update &>/dev/null
echo "apt-get upgrade..."
$(sudo apt-get upgrade -y &>/dev/null; RETVAL=0)

[[ -a /vagrant/.uname ]] && \
    uname=$(cat /vagrant/.uname)
[[ -z ${uname} ]] && \
    echo "run init USERNAME" && \
    RETVAL=1

echo "symlinking course and ${uname}..."
[[ ! -h /course ]] && \
    sudo ln -fs /vagrant/course /course
[[ ! -h /home/${uname} ]] && \
    sudo ln -fs /vagrant/home/${uname} /home/${uname}

[[ -z $LOGINCD ]] && \
    echo "[[ -d /home/${uname} ]] && cd /home/${uname}" \
         >> /home/vagrant/.bashrc && \
    echo "export LOGINCD=1" >> .profile
    export LOGINCD=1
