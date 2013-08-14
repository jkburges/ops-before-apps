include_recipe "jenkins::server"

# Plugins are not available straight away unless we do this.
# See: https://issues.jenkins-ci.org/browse/JENKINS-10061
directory "#{node['jenkins']['server']['home']}/jenkins-data/updates" do
  owner node['jenkins']['server']['user']
  group node['jenkins']['server']['user']
  recursive true
end

updates_file_name = "#{node['jenkins']['server']['home']}/jenkins-data/updates/default.json"
execute "update center" do
  command "curl -L http://updates.jenkins-ci.org/update-center.json | sed '1d;$d' > #{updates_file_name}"
  user node['jenkins']['server']['user']
  not_if { ::File.exists?(updates_file_name)}
end
