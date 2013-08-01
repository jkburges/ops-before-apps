#
# Continuous integration config for our app.
#
include_recipe 'java'

# TODO: check jenkins is ready at the beginning

# Only install plugins that aren't already installed.
installed_plugins = []
installed_plugins_check = jenkins_cli "list-plugins" do
  block do |stdout|
    stdout.each_line do |line|
      installed_plugins << line.split(' ')[0]
    end
  end
  action :nothing
end

installed_plugins_check.run_action(:run)

%w{ git grails }.each do |plugin|
  jenkins_cli "install-plugin #{plugin}" do   # TODO: sometimes this times out because jenkins hasn't initialised itself properly from update centre.
    not_if { installed_plugins.include? plugin }
  end

  jenkins_cli 'safe-restart' do
    not_if { installed_plugins.include? plugin }
  end

  # Make sure the server has properly restarted (from above plugin installation).
  # TODO: cut and paste from https://github.com/opscode-cookbooks/jenkins/blob/master/recipes/server.rb
  # Is there a way to re-use the code from there?  (Cannot simply include_recipe "jenkins::server", as
  # that results in the jenkins server ending up on the app VM).
  # TODO: refactor
  ruby_block "block_until_api_operational" do

    block do
      test_url = URI.parse("#{node['jenkins']['server']['url']}/api/json")
      Chef::Log.info "Waiting until the Jenkins API is responding (url: #{test_url})"
      until JenkinsHelper.endpoint_responding?(test_url) do
        sleep 1
        Chef::Log.debug(".")
      end
    end
  end
end


job_name = 'not-another-bookshop'
job_config = File.join('/tmp', "#{job_name}-jenkins-config.xml")

# Create a job for our app.
cookbook_file job_config do
  source "#{job_name}-jenkins-config.xml"
  notifies :update, "jenkins_job[#{job_name}]", :immediately
  notifies :build, "jenkins_job[#{job_name}]", :immediately
end

jenkins_job job_name do
  action action
  config job_config
  action :nothing
end
