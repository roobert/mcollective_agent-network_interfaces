metadata :name        => "network_interfaces",
         :description => "return a hash of network interfaces with associated information",
         :author      => "Rob Wilson",
         :version     => "1.0",
         :url         => "http://github.com/roobert/mcollective_agent-network_interfaces",
         :license     => "none",
         :timeout     => 30

action "get_hash", :description => "return a hash of interfaces with associated information" do

  display :always

  output :interfaces,
         :description => "return a hash of interfaces and associated information",
         :display_as  => "interfaces"
end
