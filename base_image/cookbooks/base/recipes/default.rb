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
