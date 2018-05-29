#created by holeun.lee@gmail.com
#this script is to create a file with all data from the alienvault database decoded and crosslinked and outputted nicely.

#!/bin/bash

#created $lastchecked variables
lastchecked=`tail -n 1 /var/log/neutrino-events.log | awk {'print $1'} | awk -F '=' {'print $2'}`
#created $file variables
file=/var/log/neutrino-events.log

if [ ! -e "$file" ]; then
        mysql -uroot -p[MASKED] -Dalienvault <<< "SELECT UNIX_TIMESTAMP(STR_TO_DATE(alarm.timestamp, '%Y-%m-%d %H:%i:%s')), alarm.protocol, inet_ntoa(conv(hex(alarm.src_ip),16,10)), inet_ntoa(conv(hex(alarm.dst_ip),16,10)), alarm.src_port, alarm.dst_port, plugin_sid.name FROM alarm INNER JOIN plugin_sid ON alarm.plugin_id=plugin_sid.plugin_id AND alarm.plugin_sid=plugin_sid.sid" 2>/dev/null | sed 1d $list |
        while IFS='\n' read -r list; do
                echo $list | awk '{print "timestamp="$1" src_ip="$3" dst_ip="$4" src_port="$5" dst_port="$6" status="$7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20}' >> /var/log/neutrino-events.log
        done

        else
        mysql -uroot -p[MASKED] -Dalienvault <<< "SELECT UNIX_TIMESTAMP(STR_TO_DATE(alarm.timestamp, '%Y-%m-%d %H:%i:%s')), alarm.protocol, inet_ntoa(conv(hex(alarm.src_ip),16,10)), inet_ntoa(conv(hex(alarm.dst_ip),16,10)), alarm.src_port, alarm.dst_port, plugin_sid.name FROM alarm INNER JOIN plugin_sid ON alarm.plugin_id=plugin_sid.plugin_id AND alarm.plugin_sid=plugin_sid.sid WHERE UNIX_TIMESTAMP(STR_TO_DATE(alarm.timestamp, '%Y-%m-%d %H:%i:%s'))>"$lastchecked 2>/dev/null | sed 1d $list |
        while IFS='\n' read -r list; do
                echo $list | awk '{print "timestamp="$1" src_ip="$3" dst_ip="$4" src_port="$5" dst_port="$6" status="$7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20}' >> /var/log/neutrino-events.log
        done
fi

