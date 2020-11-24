#!/bin/bash

. ./get_statistics.sh

echo "Used_Disk: `disk_used`"
echo "Free_Disk: `disk_free`"
echo "Used_mem: `mem_used`"
echo "Free_mem: `mem_free`"
