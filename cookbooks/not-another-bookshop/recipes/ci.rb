#
# Continuous integration config for our app.
#
include_recipe 'jenkins::server'

# We need the git and grails plugins.
# TODO: check for already installed plugins, to avoid unecessary restarts.
%w{ git grails }.each do |plugin|
  jenkins_cli "install-plugin #{plugin}" do
    notifies :run, "jenkins_cli[safe-restart]", :delayed
  end
end

jenkins_cli 'safe-restart' do
  action :nothing
  notifies :create, "ruby_block[block_until_operational]", :immediately  # wait for restart.
end


# Create a job for our app.
job_name = 'not-another-bookshop'

job_config = File.join('/tmp', "#{job_name}-jenkins-config.xml")

jenkins_job job_name do
  action :nothing
  config job_config
end

cookbook_file job_config do
  source "#{job_name}-jenkins-config.xml"
  action :nothing
  subscribes :create, "ruby_block[block_until_operational]", :delayed
  notifies :update, resources(:jenkins_job => job_name), :immediately
  notifies :build, resources(:jenkins_job => job_name), :immediately
end
