describe command('curl -d '{ "action" : "version" }' localhost:7076') do
   its('exit_status') { should eq 0 }
   its('stdout') { should eq "test\n" }
end
