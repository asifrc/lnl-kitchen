require 'spec_helper'

describe package("git") do
  it { should be_installed }
end

describe package("ruby") do
  it { should be_installed.with_version("2.0.0.598-25.el7_1") }
end
