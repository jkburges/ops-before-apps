# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu-12.04-omnibus-chef"
  config.vm.box_url = "http://grahamc.com/vagrant/ubuntu-12.04-omnibus-chef.box"

#  config.vm.network :forwarded_port, guest: 5432, host: 15432

  config.vm.provision :chef_solo do |chef|

    chef.add_recipe 'apt'
    chef.add_recipe 'postgresql'
    chef.add_recipe 'grails'
  end

  #   chef.roles_path = "roles"
  #   chef.data_bags_path = "data_bags"
  #   chef.provisioning_path = "/tmp/vagrant-chef"

  #   chef.add_recipe 'chef-solo-search'
  #   chef.add_recipe 'chef-solo-encrypted-data-bags'
  #   chef.add_recipe 'postgis'

  #   chef.json = {

  #     "postgis" => {
  #       "version" => "1"
  #     },

  #     "postgresql" => {
  #       "config" => {
  #         "listen_addresses" => "*"
  #       },
  #       "server" => {
  #         "packages" => ["postgresql-contrib"]
  #       }
  #     }
  #   }
  # end
end
