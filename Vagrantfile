# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu-12.04-omnibus-chef"
  config.vm.box_url = "http://grahamc.com/vagrant/ubuntu-12.04-omnibus-chef.box"

  def configure_vm(params)

    params[:config].vm.provider 'virtualbox' do |v, override|
      v.customize ["modifyvm", :id, "--memory", 1024]
    end

    params[:config].vm.define params[:name] do |name|
      name.vm.network :private_network, ip: params[:ip_address]
      name.vm.provision :chef_solo do |chef|
        params[:recipes].each do |recipe|
          chef.add_recipe recipe
        end

        chef.json = {
          "jenkins" => {
            "server" => {
              "url" => "http://#{params[:jenkins_address]}:8080"
            }
          }
        }
      end
    end

  end

  jenkins_address = "192.168.50.2"

  configure_vm(
    :config => config,
    :name => 'jenkins',
    :jenkins_address => jenkins_address,
    :ip_address => jenkins_address,
    :recipes => ['apt', 'not-another-bookshop::jenkins', 'not-another-bookshop::build_tools'])

  configure_vm(
    :config => config,
    :name => 'dev',
    :jenkins_address => jenkins_address,
    :ip_address => '192.168.50.3',
    :recipes => ['apt', 'not-another-bookshop::dev'])

  configure_vm(
    :config => config,
    :name => 'prod',
    :jenkins_address => jenkins_address,
    :ip_address => '192.168.50.4',
    :recipes => ['apt', 'not-another-bookshop::prod'])

end
