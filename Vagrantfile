# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu-12.04-omnibus-chef"
  config.vm.box_url = "http://grahamc.com/vagrant/ubuntu-12.04-omnibus-chef.box"

  config.vm.define :jenkins do |jenkins|
    jenkins.vm.network :private_network, ip: "192.168.50.2"

    jenkins.vm.provision :chef_solo do |chef|
      chef.add_recipe 'apt'
      chef.add_recipe 'git'
      chef.add_recipe 'grails'
      chef.add_recipe 'postgresql'
      chef.add_recipe 'jenkins::server'
    end
  end

  config.vm.define :app do |app|
    app.vm.network :private_network, ip: "192.168.50.1"

    app.vm.provision :chef_solo do |chef|
      chef.add_recipe 'apt'
      chef.add_recipe 'postgresql'
      chef.add_recipe 'grails'
      chef.add_recipe 'not-another-bookshop::ci'

      chef.json = {
        "jenkins" => {
          "server" => {
            "url" => "http://192.168.50.2:8080"
          }
        }
      }

    end
  end

end
