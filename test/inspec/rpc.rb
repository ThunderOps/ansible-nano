describe command('curl -d \'{ "action": "version" }\' localhost:7076') do
   its('exit_status') { should eq 0 }
   its('stdout') { should eq "{\n    \"rpc_version\": \"1\",\n    \"store_version\": \"10\",\n    \"node_vendor\": \"RaiBlocks 9.0\"\n}\n" }
end

describe command('curl -d \'{ "action": "available_supply" }\' localhost:7076') do
   its('exit_status') { should eq 0 }
   its('stdout') { should eq "{\n    \"available\": \"133248289219696000000000000000000000001\"\n}\n" }
end

describe command('curl -d \'{ "action": "block_count" }\' localhost:7076') do
   its('exit_status') { should eq 0 }
   # its('stdout') { should eq "{\n    \"count\": \"4996678\",\n    \"unchecked\": \"2\"\n}\n" }
end

describe command('curl -d \'{ "action": "block_count_type" }\' localhost:7076') do
   its('exit_status') { should eq 0 }
   # its('stdout') { should eq "{\n    \"send\": \"2512370\",\n    \"receive\": \"2154118\",\n    \"open\": \"317366\",\n    \"change\": \"12839\"\n}\n" }
end

describe command('curl -d \'{ "action": "bootstrap_any" }\' localhost:7076') do
   its('exit_status') { should eq 0 }
   its('stdout') { should eq "{\n    \"success\": \"\"\n}\n" }
end

describe command('curl -d \'{ "action": "frontier_count" }\' localhost:7076') do
   its('exit_status') { should eq 0 }
   # its('stdout') { should eq "{\n    \"count\": \"317371\"\n}\n" }
end

describe command('curl -d \'{ "action": "receive_minimum" }\' localhost:7076') do
   its('exit_status') { should eq 0 }
   its('stdout') { should eq "{\n    \"amount\": \"1000000000000000000000000\"\n}\n" }
end

describe command('curl -d \'{ "action": "representatives" }\' localhost:7076') do
   its('exit_status') { should eq 0 }
   # Returns a list of pairs of representative and its voting weight
end

describe command('curl -d \'{ "action": "search_pending_all" }\' localhost:7076') do
   its('exit_status') { should eq 0 }
   its('stdout') { should eq "{\n    \"success\": \"\"\n}\n" }
end

describe command('curl -d \'{ "action": "peers" }\' localhost:7076') do
   its('exit_status') { should eq 0 }
   # Returns a list of pairs of peer IPv6:port and its node network version
end


describe command('curl -d \'{ "action": "unchecked" }\' localhost:7076') do
   its('exit_status') { should eq 0 }
   # Returns a list of pairs of unchecked synchronizing block hash and its json representation
end

describe command('curl -d \'{ "action": "work_peers" }\' localhost:7076') do
   its('exit_status') { should eq 0 }
   its('stdout') { should eq "{\n    \"work_peers\": \"\"\n}\n" }
end
