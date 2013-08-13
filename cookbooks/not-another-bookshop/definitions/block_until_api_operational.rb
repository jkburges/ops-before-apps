# Make sure the server has properly restarted (from above plugin installation).
# TODO: cut and paste from https://github.com/opscode-cookbooks/jenkins/blob/master/recipes/server.rb
# Is there a way to re-use the code from there?  (Cannot simply include_recipe "jenkins::server", as
# that results in the jenkins server ending up on the app VM).
# TODO: refactor
define :block_until_api_operational, :url => nil do
  ruby_block "block_until_api_operational" do

    block do
      test_url = URI.parse(params[:url])
      Chef::Log.info "Waiting until url responding (url: #{test_url})"
      until JenkinsHelper.endpoint_responding?(test_url) do
        sleep 1
        Chef::Log.debug(".")
      end
    end
  end
end
