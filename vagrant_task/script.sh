#!/usr/bin/env bash

dock_inst () {
    sudo apt-get install -y curl apt-transport-https ca-certificates software-properties-common
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt update
    sudo apt install -y docker-ce
    sudo apt install -y docker-compose
}

clone_repo () {
    git clone git@github.com:PeterBrazzz/scripts.git
    cd ./scripts
    git checkout develop
    cd ./vagrant_task/dockerfiles_for_task/
}

sudo apt-get update
sudo apt-get -y upgrade
dock_inst
sudo chmod 400 /home/vagrant/.ssh/id_rsa /home/vagrant/.ssh/id_rsa.pub
clone_repo
sudo docker-compose up -d
