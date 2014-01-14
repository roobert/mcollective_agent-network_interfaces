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
$ mco rpc network_interfaces get_hash -I devmcollective0

 * [ ============================================================> ] 1 / 1


devmcollective0                           
   interfaces: {:eth1=>{:member=>"bond0", :mac_address=>"00:00:00:01:02:0A"},
                :eth2=>
                 {:member=>"bond1", :active_in_bond=>true, :mac_address=>"00:00:00:01:02:0B"},
                :eth4=>{:mac_address=>"00:10:18:c0:e8:84"},
                :eth3=>{:member=>"bond1", :mac_address=>"00:00:00:01:02:0B"},
                :bond1=>
                 {:slaves=>["eth2", "eth3"],
                  :active_interface=>"eth2",
                  :ip_addresses=>["10.3.24.116"],
                  :mac_address=>"00:00:00:01:02:0B"},
                :eth0=>
                 {:member=>"bond0", :active_in_bond=>true, :mac_address=>"00:00:00:01:02:0A"},
                :bond0=>
                 {:slaves=>["eth0", "eth1"],
                  :active_interface=>"eth0",
                  :ip_addresses=>["10.3.0.116", "10.3.0.117", "10.3.0.118", "10.3.0.119"],
                  :mac_address=>"00:00:00:01:02:0A"},
                :eth5=>{:mac_address=>"00:10:18:c0:e8:86"}}



Finished processing 1 / 1 hosts in 842.73 ms
```

JSON output:

```
$ mco rpc network_interfaces get_hash -I devmcollective0 -j
[
  {
    "statusmsg": "OK",
    "agent": "network_interfaces",
    "data": {
      "interfaces": {
        "eth1": {
          "member": "bond0",
          "mac_address": "00:00:00:01:02:0A"
        },
        "eth2": {
          "member": "bond1",
          "active_in_bond": true,
          "mac_address": "00:00:00:01:02:0B"
        },
        "eth4": {
          "mac_address": "00:10:18:c0:e8:84"
        },
        "eth3": {
          "member": "bond1",
          "mac_address": "00:00:00:01:02:0B"
        },
        "bond1": {
          "active_interface": "eth2",
          "ip_addresses": [
            "10.3.24.116"
          ],
          "mac_address": "00:00:00:01:02:0B",
          "slaves": [
            "eth2",
            "eth3"
          ]
        },
        "eth0": {
          "member": "bond0",
          "active_in_bond": true,
          "mac_address": "00:00:00:01:02:0A"
        },
        "bond0": {
          "active_interface": "eth0",
          "ip_addresses": [
            "10.3.0.116",
            "10.3.0.117",
            "10.3.0.118",
            "10.3.0.119"
          ],
          "mac_address": "00:00:00:01:02:0A",
          "slaves": [
            "eth0",
            "eth1"
          ]
        },
        "eth5": {
          "mac_address": "00:10:18:c0:e8:86"
        }
      }
    },
    "action": "get_hash",
    "sender": "devmcollective0",
    "statuscode": 0
  }
]
```
