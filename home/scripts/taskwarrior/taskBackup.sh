#!/bin/bash

cd $HOME && tar -czvf backups/taskwarrior/task-backup-$(date +'%Y%m%d%H%M%S').tar.gz .task/* &&
tar -czvf backups/taskwarrior/time-backup-$(date +'%Y%m%d%H%M%S').tar.gz .timewarrior/data*
