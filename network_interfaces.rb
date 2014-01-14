#!/usr/bin/env ruby

module MCollective
  module Agent
    class Network_interfaces<RPC::Agent
      action "get_hash" do

        interfaces = %x{ip l | grep -v ether | grep --color=no -E 'bond|eth' | awk '{ print $2 }' | cut -d: -f1 | sort}

        db = {}

        interfaces.each do |interface|

          # first work out mac address and ip address information

          interface_info = `ip address show dev #{interface}`

          interface = interface.chomp.to_sym

          db[interface] = {}

          interface_info.each_line do |line|

            if line =~ /    link\/ether /
              db[interface][:mac_address] = line.scan(/    link\/ether (..:..:..:..:..:..)/)[0][0]
            end

            if line =~ /    inet /
              db[interface][:ip_addresses] = [] unless db[interface].key? :ip_addresses

              db[interface][:ip_addresses].push line.scan(/    inet (\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\//)[0][0]
            end
          end

          # if bonding is enabled then add some useful bonding information

          next unless File.directory?("/proc/net/bonding")

          case interface.to_s
          when /bond/

            # silently fail!
            next unless File.readable?("/proc/net/bonding/#{interface}")

            next unless system("grep 'Slave Interface'        /proc/net/bonding/#{interface} > /dev/null 2>&1")
            next unless system("grep 'Currently Active Slave' /proc/net/bonding/#{interface} > /dev/null 2>&1")

            slaves           = `cat /proc/net/bonding/#{interface} | grep --color=no 'Slave Interface'        | cut -d: -f2 | tr -d '[:blank:]'`
            active_interface = `cat /proc/net/bonding/#{interface} | grep --color=no 'Currently Active Slave' | cut -d: -f2 | tr -d '[:blank:]'`

            db[interface][:active_interface] = active_interface.chomp
            db[interface][:slaves]           = slaves.split

          when /eth/

            next unless system("grep #{interface} /proc/net/bonding/* > /dev/null 2>&1")

            member = `basename $(grep -H --color=no #{interface} /proc/net/bonding/* | cut -d: -f 1 | uniq)`

            db[interface][:member] = member.chomp

            active_interface = `cat /proc/net/bonding/#{member.chomp} | grep --color=no 'Currently Active Slave' | cut -d: -f2 | tr -d '[:blank:]'`

            db[interface][:active_in_bond] = true if active_interface.chomp == interface.to_s
          end
        end

        reply[:interfaces] = db
      end
    end
  end
end
