require 'spec_helper'

describe command("echo Hello World") do
  its(:stdout) { should match "Hello World" }
end
