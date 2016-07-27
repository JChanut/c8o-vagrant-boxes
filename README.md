ddsim-pmm-vagrant-boxes
=======================

This is the repository for creating and building Vagrant boxes for PMM.

The purpose of the project is to offer base boxes for all pmm projects that will be deployed on an Ubuntu environment
and that will use the Convertigo FullSync functionnality.

For now, 2 base boxes are available:
* ddsim-pmm/ubuntu-14.04.2
* ddsim-pmm/ubuntu-12.04.4

Each box include a Convertigo and a CouchDB server installation ready to use:

* Convertigo 7.4.0-v41819-linux32
* CouchDB 1.6.1

Prerequisite
-------------
Before building the box, you need some prerequisites:

* Packer (Create machine images for multiple platforms from a single source configuration)
* Vagrant (Configure reproducible and portable work environments)
* VirtualBox (Virtualization)
* Cntlm (local http proxy)

> For a more detailed how-to on setting up a Vagrant environment, check the [pmm wiki](http://alm.sncf.fr/sources/pmm/starter-kit-pmm/wikis/home#config-vagrant)

How to build the Vagrant box
----------------------------
Once you have clone the git repo and installed Packer, launch the builds with the following command:
```sh
$ packer build pmm-template.json
```
> It will build the 2 boxes in the `build` directory
