# We need the git and grails plugins.
%w{ git grails }.each do |plugin|
  jenkins_cli "install-plugin #{plugin}"
end

jenkins_cli 'safe-restart'
