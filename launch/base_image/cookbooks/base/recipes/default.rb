package "git"

package "ruby" do
  version "2.0.0.648-29.el7"
end

gem_package "bundler"

gem_package "test-kitchen" do
  version "1.16.0"
end

gem_package "kitchen-ec2"
gem_package "kitchen-sync"
gem_package "kitchen-vagrant"

package "epel-release"
package "sshpass"

USER = node['base']['user']

cookbook_file "/home/#{USER}/.ssh/id_rsa" do
  source "vagrant_insecure_key"
  mode '0600'
  owner "#{USER}"
  group "#{USER}"
end

cookbook_file "/home/#{USER}/.ssh/id_rsa.pub" do
  source "vagrant_insecure_key.pub"
  mode '0644'
  owner "#{USER}"
  group "#{USER}"
end

cookbook_file "/home/#{USER}/.ssh/vagrant_insecure" do
  source "vagrant_insecure_key"
  mode '0600'
  owner "#{USER}"
  group "#{USER}"
end

cookbook_file "/home/#{USER}/.ssh/vagrant_insecure.pub" do
  source "vagrant_insecure_key.pub"
  mode '0644'
  owner "#{USER}"
  group "#{USER}"
end

package "vim-enhanced"

env_vars = {}
env_vars['AWS_ACCESS_KEY_ID'] = node['project']['aws']['access_key']
env_vars['AWS_SECRET_ACCESS_KEY'] = node['project']['aws']['secret_key']

template "/home/#{USER}/.bashrc" do
  source "bashrc.erb"
  sensitive true
  variables :env_vars => env_vars
end

git "/home/#{USER}/lnl-kitchen" do
  repository "https://github.com/asifrc/lnl-kitchen.git"
  user "#{USER}"
  group "#{USER}"
  action :sync
end

remote_file "/tmp/janus.tar.gz" do
  source "https://s3.amazonaws.com/launchandlearn/twu/janus.tar.gz"
end

execute "tar -xvzf /tmp/janus.tar.gz" do
  cwd "/home/centos"
  action :run
end

link "/home/centos/.vimrc" do
  to "/home/centos/.vim/janus/vim/vimrc"
end
