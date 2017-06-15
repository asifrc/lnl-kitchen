require 'spec_helper'

USER="centos"

describe package("git") do
  it { should be_installed }
end

describe package("ruby") do
  it { should be_installed.with_version("2.0.0.648-29.el7") }
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


context "Vagrant" do
  describe file("/home/#{USER}/.ssh/id_rsa") do
    it { should exist }
    it { should be_mode 600 }
  end

  describe file("/home/#{USER}/.ssh/id_rsa.pub") do
    it { should exist }
    it { should be_mode 644 }
  end
  describe file("/home/#{USER}/.ssh/vagrant_insecure") do
    it { should exist }
    it { should be_mode 600 }
  end
  describe file("/home/#{USER}/.ssh/vagrant_insecure.pub") do
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

  describe file("/home/#{USER}/lnl-kitchen/.git/config") do
    its(:content) { should match "lnl-kitchen.git" }
  end

  describe file("/home/#{USER}/.vim") do
    it { should be_directory }
  end

  describe file("/home/#{USER}/.vimrc") do
    it { should be_symlink }
  end
end
