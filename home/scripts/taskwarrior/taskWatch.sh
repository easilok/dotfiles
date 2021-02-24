#!/bin/bash

taskArgs=''


if [ $# -gt 0 ]
then
  taskArgs="$@"
fi

# Draw first time
clear
task $taskArgs



#infinit loop to draw tasks
while sleep 30s;
do
  clear
  task $taskArgs
done
