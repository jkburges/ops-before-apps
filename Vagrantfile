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
      chef.add_recipe 'jenkins::server'
      chef.add_recipe 'not-another-bookshop::build_tools'

      chef.json = {
        "jenkins" => {
          "server" => {
            "url" => "http://#{jenkins_address}:8080"
          }
        },
        "apt" => {
          "cacher_ipaddress" => "aptcacher.emii.org.au"
        }
      }

    end
  end

  config.vm.define :app do |app|
    app.vm.network :private_network, ip: "192.168.50.1"

    app.vm.provision :chef_solo do |chef|
      chef.add_recipe 'apt'
#      chef.add_recipe 'not-another-bookshop::ci'
      chef.add_recipe 'not-another-bookshop::build_tools'
      chef.add_recipe 'not-another-bookshop::deploy'

      chef.json = {
        "jenkins" => {
          "server" => {
            "url" => "http://#{jenkins_address}:8080"
          }
        },
        "apt" => {
          "cacher_ipaddress" => "aptcacher.emii.org.au"
        }
      }

      chef.log_level = :debug

    end
  end

end
