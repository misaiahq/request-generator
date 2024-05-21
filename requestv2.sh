#!/bin/bash

i=1
max=10000
interval=1.3
req=100
## Default
url="http://google.com/"

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
echo "$(date)" >> request.log
#printf "%(%Y-%m-%d %H:%M:%S)T | Requests:$req | Interval:${interval} | Max=${max} | URL=${url} | Concurrency:${c} \n" >> request.log
echo "$(date) | Requests:$req | Interval:${interval} | Max=${max} | URL=${url} | Concurrency:${c} " >> request.log
while [ $i -le $max ]
do
  printf %.1f%% "$((10**4 * ${i}/${max}*100))e-4" >> request.log
  echo " | [${i}/${max}] Sending ${req} requests to ${url} using ${c} concurrent thread(s) in ${interval}-second intervals." >> request.log
  #echo "Iteration: ${i}/${max}" >> request.log
  ab -n $req -c $c $url >> requestv2.log >> request.log
  sleep $interval
  ((i++))
done
echo "Execution complete."
