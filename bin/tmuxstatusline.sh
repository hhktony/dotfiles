#!/usr/bin/env bash

cpustr=`vmstat|tail -n 1 | awk '{print $13}'`
memstr=`free | head -n 2 | tail -n 1 | awk '{printf("%.1f",$3/$2*100)}' `
# echo "| CPU:"$cpustr"%"
