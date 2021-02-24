#!/bin/bash

taskArgs=''


if [ $# -gt 0 ]
then
  taskArgs="$@"
fi

task $taskArgs

