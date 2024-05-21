#!/bin/bash

i=1
max=10000
interval=1.3
req=100
## Default
url="http://192.168.7.106:8081/Test"
#url="http://192.168.7.106:8081/Privacy"

### For Deletion
#while [ $i -le $max ]
#do
#  echo "Iteration: ${i}/${max}"
#  #ab -n $req -c 1 http://192.168.7.106:8082/Home/Employees
#  ab -n $req -c 1 $url
#  sleep $interval
#  ((i++))
#done
###

if [ -z "$1" ]
then
    echo "Running in test mode"
    firstname="Adam"
    secondname="& Eve"
    max=3
    interval=1
    req=1
    c=1
else
    while [[ "$#" -gt 0 ]]
    do case $1 in
        -m|--max) max="$2"
        shift;;
        -i|--interval) interval="$2"
        shift;;
        -r|--requests) req="$2"
        shift;;
        -u|--url) url="$2"
        shift;;
        -c|--concurrency) c="$2"
        shift;;
        *) echo "Unknown parameter passed: $1"
        exit 1;;
    esac
    shift
    done
fi

#start=date
echo "$(date)"
#printf "%(%Y-%m-%d %H:%M:%S)T | Requests:$req | Interval:${interval} | Max=${max} | URL=${url} | Concurrency:${c} \n" > requestv2.log
echo "$(date) | Requests:$req | Interval:${interval} | Max=${max} | URL=${url} | Concurrency:${c} 
" > requestv2.log
while [ $i -le $max ]
do
  printf %.1f%% "$((10**4 * ${i}/${max}*100))e-4"
  echo " | [${i}/${max}] Sending ${req} requests to ${url} using ${c} concurrent thread(s) in ${interval}-second intervals."
  #echo "Iteration: ${i}/${max}"
  ab -n $req -c $c $url >> requestv2.log
  sleep $interval
  ((i++))
done
echo "Execution complete."
