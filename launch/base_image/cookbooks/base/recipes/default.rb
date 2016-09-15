package "git"

package "ruby" do
  version "2.0.0.598-25.el7_1"
end

gem_package "bundler"

gem_package "test-kitchen" do
  version "1.12.0"
end

gem_package "kitchen-ec2"
gem_package "kitchen-sync"

package "epel-release"
package "sshpass"

user "centos" do
  password "#{node['base']['user']['encrypted_password']}"
end

service "sshd" do
  action :nothing
end

cookbook_file "/etc/ssh/sshd_config" do
  source "sshd_config"
  mode '0644'
  owner 'root'
  group 'root'
  notifies :restart, "service[sshd]", :immediately
end

cookbook_file "/home/centos/.ssh/id_rsa" do
  source "vagrant_insecure_key"
  mode '0600'
  owner 'centos'
  group 'centos'
end

cookbook_file "/home/centos/.ssh/id_rsa.pub" do
  source "vagrant_insecure_key.pub"
  mode '0644'
  owner 'centos'
  group 'centos'
end

package "vim-enhanced"

env_vars = {}
env_vars['AWS_ACCESS_KEY_ID'] = node['project']['aws']['access_key']
env_vars['AWS_SECRET_ACCESS_KEY'] = node['project']['aws']['secret_key']

template "/home/centos/.bashrc" do
  source "bashrc.erb"
  sensitive true
  variables :env_vars => env_vars
end

git "/home/centos/lnl-kitchen" do
  repository "https://github.com/asifrc/lnl-kitchen.git"
  user 'centos'
  group 'centos'
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
