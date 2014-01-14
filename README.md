# MCollective Agent for Network Interface Information

## About

An agent that returns each network interface on a machine along with the interfaces associated information.

## Examples

Help:

```
$ mco plugin doc network_interfaces 
network_interfaces
==================

return a hash of network interfaces with associated information

      Author: Rob Wilson
     Version: 1.0
     License: none
     Timeout: 30
   Home Page: http://github.com/roobert/mcollective_agent-network_interfaces

ACTIONS:
========
   get_hash

   get_hash action:
   ----------------
       return a hash of interfaces with associated information

       INPUT:

       OUTPUT:
           interfaces:
              Description: return a hash of interfaces and associated information
               Display As: interfaces
```

Normal output:

```
$ mco rpc network_interfaces get_hash -1
Discovering hosts using the mc method for 2 second(s) .... 1

 * [ ============================================================> ] 1 / 1


foo.example.com
   interfaces: {:bond1=>
                 {:mac_address=>"00:00:00:01:02:0B",
                  :slaves=>["eth1"],
                  :active_interface=>"eth1",
                  :ip_addresses=>["10.3.25.37"]},
                :bond0=>
                 {:mac_address=>"00:00:00:01:02:0A",
                  :slaves=>["eth0"],
                  :active_interface=>"eth0",
                  :ip_addresses=>
                   ["10.3.1.37", "10.3.1.38", "10.3.1.39", "10.3.1.40", "10.3.1.41"]},
                :eth0=>
                 {:active_in_bond=>true, :member=>"bond0", :mac_address=>"00:00:00:01:02:0A"},
                :eth1=>
                 {:active_in_bond=>true, :member=>"bond1", :mac_address=>"00:00:00:01:02:0B"}}


Finished processing 1 / 1 hosts in 294.67 ms
```

JSON output:

```
$ mco rpc network_interfaces get_hash -j -1
[
  {
    "statusmsg": "OK",
    "agent": "network_interfaces",
    "data": {
      "interfaces": {
        "eth0": {
          "active_in_bond": true,
          "member": "bond0",
          "mac_address": "00:00:00:01:02:0A"
        },
        "bond1": {
          "ip_addresses": [
            "10.3.25.37"
          ],
          "slaves": [
            "eth1"
          ],
          "active_interface": "eth1",
          "mac_address": "00:00:00:01:02:0B"
        },
        "eth1": {
          "active_in_bond": true,
          "member": "bond1",
          "mac_address": "00:00:00:01:02:0B"
        },
        "bond0": {
          "ip_addresses": [
            "10.3.1.37",
            "10.3.1.38",
            "10.3.1.39",
            "10.3.1.40",
            "10.3.1.41"
          ],
          "slaves": [
            "eth0"
          ],
          "active_interface": "eth0",
          "mac_address": "00:00:00:01:02:0A"
        }
      }
    },
    "action": "get_hash",
    "sender": "foo.example.com",
    "statuscode": 0
  }
]
```
