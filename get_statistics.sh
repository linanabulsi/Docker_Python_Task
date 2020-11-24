#!/usr/bin/env sh

mem_used() {
    free | awk ' NR == 2 {print $3}'
}

mem_free() {
    free | awk ' NR == 2 {print $4}'
}

disk_used() {
    df | grep '/dev/mapper/centos-root' | awk ' {print $3}'
}

disk_free() {
    df | grep '/dev/mapper/centos-root' | awk ' {print $4}'
}

cpu_usage() {
    mpstat | tail -n 1 | awk '{ print $13 }'
}
