#!/bin/bash

set -e

sudo apt-get update
sudo apt-get upgrade -y
sudo ln -s /vagrant/course /course
sudo ln -s /vagrant/home/* /home/
