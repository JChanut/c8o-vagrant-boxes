c8o-vagrant-boxes
=======================

The purpose of the project is to offer base Vagrant boxes for all pmm projects that will be deployed on an Ubuntu environment
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

How to build the Vagrant box
----------------------------
Once you have clone the git repo and install Packer, launch the builds with the following command:
```sh
$ packer build pmm-template.json
```
> It will build the 2 boxes in the `build` directory

Testing the boxes locally
-------------------------
In order to test the 2 new boxes, you can launch the following script:
```sh
$ packer build pmm-template.json
```
> It will adding the boxes to Vagrant and starting them with the `Vagrantfile` at the root of the repo

How to use the boxes
------------------------------------

Developpers can now create Vagrant environment for their projects by using the following configuration 
in their `Vagrantfile`:

```ruby
Vagrant.configure(2) do |config|
    # Use the following config for the Ubuntu 12.04 box
    config.vm.box = "ddsim-pmm/ubuntu-12.04.4"
    config.vm.box_url = "http://10.105.132.141:8080/docs-caasm/pmm-vagrant-boxes/ddsim-pmm-ubuntu-12.04.4_virtualbox.box"

    # Use the following config for the Ubuntu 14.04 box
    config.vm.box = "ddsim-pmm/ubuntu-14.04.2"
    config.vm.box_url = "http://10.105.132.141:8080/docs-caasm/pmm-vagrant-boxes/ddsim-pmm-ubuntu-14.04.2_virtualbox.box"
end
```