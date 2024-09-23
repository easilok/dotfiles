#!/usr/bin/env bash

# Reset context ignoring errors
task rc.confirmation=0 context none
# Rotate tasks
task rc.bulk=0 +tomorrow modify -tomorrow +today && task rc.bulk=0 +today modify -today +yesterday
