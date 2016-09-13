require 'spec_helper'

describe package("git") do
  it { should be_installed }
end

describe package("ruby") do
  it { should be_installed.with_version("2.0.0.598-25.el7_1") }
end

describe package("bundler") do
  it { should be_installed.by("gem") }
end

describe package("test-kitchen") do
  it { should be_installed.by("gem").with_version("1.12.0") }
end

describe package("kitchen-ec2") do
  it { should be_installed.by("gem") }
end

describe package("kitchen-sync") do
  it { should be_installed.by("gem") }
end


context "should authenticate via password" do
  PASSWORD="notsecure"
  describe package("epel-release") do
    it { should be_installed }
  end

  describe package("sshpass") do
    it { should be_installed }
  end

  describe user("centos") do
    its(:encrypted_password) { should_not match(/^.{0,2}$/) }
  end

  describe command("sshpass -p#{PASSWORD} ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no centos@localhost exit") do
    its(:exit_status) { should eq 0 }
  end
end
