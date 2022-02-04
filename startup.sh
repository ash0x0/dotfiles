#!/bin/bash

redshift </dev/null >/dev/null 2>&1 &

cd $HOME/bin/activitywatch
nohup ./aw-qt </dev/null >/dev/null 2>&1 &
disown
notify-send "ActivityWatch started"
