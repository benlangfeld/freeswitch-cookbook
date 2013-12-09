# -*- mode: ruby -*-
# vi: set ft=ruby :

public_ip = '10.10.10.10'

Vagrant.configure("2") do |config|
  config.vm.box = "centos"
  config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_centos-6.4_provisionerless.box"

  config.berkshelf.enabled = true

  config.vm.network :private_network, ip: public_ip

  config.vm.provider :virtualbox do |vb|
    # Give enough horsepower to build without taking all day.
    vb.customize [
      "modifyvm", :id,
      "--memory", "1536",
      "--cpus", "2"
    ]
  end

  config.omnibus.chef_version = :latest

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe 'freeswitch'
    chef.json = {
      freeswitch: {
        local_ip: public_ip,
        domain:   public_ip,
        install_method: 'source',
      }
    }
  end
end
