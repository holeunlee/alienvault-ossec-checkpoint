#!/bin/bash
#make some variables
TOTAL=$(cat /proc/sys/fs/file-nr | awk '{print $1}')
HARDLIMIT=$(ulimit -Hn)
CRITZONE=`echo $HARDLIMIT*0.25 | bc -l`
WARNZONE=`echo $HARDLIMIT*0.5 | bc -l`
OKZONE=`echo $HARDLIMIT*0.75 | bc -l`

CRIT=`echo $HARDLIMIT-$CRITZONE | bc -l`
WARN=`echo $HARDLIMIT-$WARNZONE | bc -l`
OK=`echo $HARDLIMIT-$OKZONE | bc -l`
	WARN=$( printf "%.0f" $WARN )
	CRIT=$( printf "%.0f" $CRIT )
	OK=$( printf "%.0f" $OK )

#DEBUG:
	#echo "TOTAL: $TOTAL"
	#echo "HARDLIMIT: $HARDLIMIT"
	#echo "WARN: $WARN"
	#echo "CRIT: $CRIT"
	#echo "OK: $OK"
	#echo "$TOTAL groter dan $WARN"
	#echo "$TOTAL groter dan $CRIT"

#onto working it, and giving some data to our monitoring

if [ $TOTAL -gt $CRIT ]
	then
		#CRIT
		EXIT=2
		STATUS="CRIT: open files $TOTAL reached 75% of hard limit $HARDLIMIT" 
 
elif [ $TOTAL -gt $WARN ]
	then
		#WARN 
		EXIT=1
		STATUS="WARN: open files $TOTAL reached 50% of hard limit $HARDLIMIT"

else
		#OK
		EXIT=0
		STATUS="OK: open files are $TOTAL of $HARDLIMIT"

fi
		echo "$STATUS"
		exit $EXIT

