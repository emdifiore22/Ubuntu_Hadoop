#!/bin/bash

service ssh start;
exec opt/hadoop/hadoop/sbin/start-all.sh
