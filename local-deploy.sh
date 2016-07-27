#!/usr/bin/env bash

vagrant destroy -f
vagrant box remove ddsim-pmm/ubuntu-12.04.4
vagrant box remove ddsim-pmm/ubuntu-14.04.2
vagrant box add pmm-ubuntu-12.04.4-vagrant.json
vagrant box add pmm-ubuntu-14.04.2-vagrant.json
vagrant up