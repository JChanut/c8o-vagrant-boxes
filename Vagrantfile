# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vbguest.auto_update = false

  config.vm.define "precise" do |precise|
    precise.vm.box = "ddsim-pmm/ubuntu-12.04.4"
    precise.vm.network "forwarded_port", guest: 5984, host: 5984
    precise.vm.network "forwarded_port", guest: 28080, host: 28080
  end

  config.vm.define "trusty" do |trusty|
    trusty.vm.box = "ddsim-pmm/ubuntu-14.04.2"
    trusty.vm.network "forwarded_port", guest: 5984, host: 5985
    trusty.vm.network "forwarded_port", guest: 28080, host: 28081
  end

  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = "http://#{`hostname`[0..-2]}:3128"
    config.proxy.https    = "http://#{`hostname`[0..-2]}:3128"
    #config.apt_proxy.http = "http://iisprdproxy.dsit.sncf.fr:3128/"
    #config.apt_proxy.https = "http://iisprdproxy.dsit.sncf.fr:3128/"
    config.proxy.no_proxy = "localhost,127.0.0.1,#{`hostname`[0..-2]}"
  end
end
