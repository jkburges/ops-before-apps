# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu-12.04-omnibus-chef"
  config.vm.box_url = "http://grahamc.com/vagrant/ubuntu-12.04-omnibus-chef.box"

  jenkins_address = "192.168.50.2"

  config.vm.define :jenkins do |jenkins|

    jenkins.vm.network :private_network, ip: jenkins_address

    jenkins.vm.provision :chef_solo do |chef|
      chef.add_recipe 'apt'
      chef.add_recipe 'not-another-bookshop::jenkins'
      chef.add_recipe 'not-another-bookshop::build_tools'

      chef.json = {
        "jenkins" => {
          "server" => {
            "url" => "http://#{jenkins_address}:8080"
          }
        }
      }
    end
  end

  config.vm.define :dev do |dev|
    dev.vm.network :private_network, ip: "192.168.50.3"

    dev.vm.provision :chef_solo do |chef|
      chef.add_recipe 'apt'
      chef.add_recipe 'not-another-bookshop::dev'

      chef.json = {
        "jenkins" => {
          "server" => {
            "url" => "http://#{jenkins_address}:8080"
          }
        }
      }
    end
  end

  config.vm.define :prod do |prod|
    prod.vm.network :private_network, ip: "192.168.50.4"

    prod.vm.provision :chef_solo do |chef|
      chef.add_recipe 'apt'
      chef.add_recipe 'not-another-bookshop::prod'

      chef.json = {
        "jenkins" => {
          "server" => {
            "url" => "http://#{jenkins_address}:8080"
          }
        }
      }
    end
  end


end
