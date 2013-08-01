include_recipe 'application'

application 'not-another-bookshop' do
  path '/usr/local/not-another-bookshop'
  owner node['tomcat']['user']
  group node['tomcat']['group']
  repository "#{node['jenkins']['server']['url']}/job/not-another-bookshop/lastSuccessfulBuild/artifact/target/not-another-bookshop-0.1.war"
  scm_provider Chef::Provider::RemoteFile::Deploy

  java_webapp
  tomcat

end

directory node['tomcat']['base'] do
  owner node['tomcat']['user']
  group node['tomcat']['group']
end

# Remove ROOT.xml or else we get exceptions in the log.
file "#{node['tomcat']['config_dir']}/Catalina/localhost/ROOT.xml" do
  action :delete
end
