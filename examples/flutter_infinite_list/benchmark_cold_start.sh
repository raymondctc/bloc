#!/bin/bash

NUM_OF_EXECUTIONS=$2

for (( i=1; i<=$NUM_OF_EXECUTIONS; i++ ))
do
    ./start_cold.sh $1 | grep "TotalTime: " | sed 's/TotalTime: //'
done
