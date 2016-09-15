require 'spec_helper'

describe command("echo Hello World") do
  its(:stdout) { should eq "Hello World" }
end
