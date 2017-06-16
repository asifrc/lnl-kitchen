ssh_params = "ssh -o StrictHostKeyChecking=no -i #{ENV['HOME']}/.ssh/vagrant_insecure"
dir_name = File.basename(Dir.pwd)
remote_location = "#{ENV['WORKSTATION_IP']}:~/#{dir_name}"
exclude_files = "--exclude ./learn/.kitchen"
exclude_files = "#{exclude_files} --exclude ./launch/base_image/.kitchen "
rsync_command="rsync #{exclude_files} -avzhe  \"#{ssh_params}\" . #{remote_location} --delete"

puts rsync_command
`#{rsync_command}`

guard :shell do
  watch(/.*/) do |m|
    `#{rsync_command}`
  end
end
