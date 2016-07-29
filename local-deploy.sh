#!/usr/bin/env bash
echo 'Destroy previously created Vagrant vm'
vagrant destroy -f

echo
echo 'Remove old pmm boxes from Vagrant'
vagrant box remove jchanut/ubuntu-12.04.4
vagrant box remove jchanut/ubuntu-14.04.2

echo
echo 'Adding new pmm boxes to Vagrant'
vagrant box add c8o-ubuntu-12.04.4-vagrant.json
vagrant box add c8o-ubuntu-14.04.2-vagrant.json

echo
echo 'Starting Vagrant vm'
vagrant up