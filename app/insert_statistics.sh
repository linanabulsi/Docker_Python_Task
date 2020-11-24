#!/bin/bash

#cd /root/demo5/app
. ./get_statistics.sh
#cd /root/demo5
time=$(date +"%H:%M:%S")
echo $time

#time1=$(date +"%s")
#echo $time1

time2=$(date +"%m/%d/%Y,%H:%M:%S")
#echo $time2

#echo "INSERT INTO disk_usage (Used, Free) VALUES (mem_used, mem_free);" | docker-compose exec -T db mysql -uroot -proot statistics

echo "INSERT INTO \`mem_usage\` (\`Used\`,\`Free\`) VALUES (`mem_used`,`mem_free`);" | docker-compose exec -T db mysql -uroot -proot statistics
echo "INSERT INTO \`disk_usage\` (\`Used\`,\`Free\`) VALUES (`disk_used`,`disk_free`);" | docker-compose exec -T db mysql -uroot -proot statistics
#echo "INSERT INTO \`cpu_usage\` (\`Usage\`, \`Taken_at\`) VALUES (`cpu_usage`,'$time2');" | docker-compose exec -T db mysql -uroot -proot statistics
echo "INSERT INTO \`cpu_usage\` (\`Usage\`) VALUES (`cpu_usage`);" | docker-compose exec -T db mysql -uroot -proot statistics

#echo "u: `mem_used`, f: `mem_free`"

#echo "INSERT INTO disk_usage (Used,Free) VALUES (`disk_used`,`disk_free`);" | docker-compose exec -T db mysql -uroot -proot statistics

