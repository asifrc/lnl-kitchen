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

context "Test Kitchen gems" do
  describe package("test-kitchen") do
    it { should be_installed.by("gem").with_version("1.12.0") }
  end

  describe package("kitchen-ec2") do
    it { should be_installed.by("gem") }
  end

  describe package("kitchen-sync") do
    it { should be_installed.by("gem") }
  end
end

context "User centos should authenticate via password" do
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

context "Vagrant" do
  describe file("/home/centos/.ssh/id_rsa") do
    it { should exist }
    it { should be_mode 600 }
  end

  describe file("/home/centos/.ssh/id_rsa.pub") do
    it { should exist }
    it { should be_mode 644 }
  end
end

context "Project" do
  describe package("vim-enhanced") do
    it { should be_installed }
  end

  describe command("echo $AWS_ACCESS_KEY_ID") do
    its(:stdout) { should match "AKIA" }
  end

  describe command("echo $AWS_SECRET_ACCESS_KEY") do
    its(:stdout) { should_not eq "\n" }
  end

  describe file("/home/centos/lnl-kitchen/.git/config") do
    its(:content) { should match "lnl-kitchen.git" }
  end
end
