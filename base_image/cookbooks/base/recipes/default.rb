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
