#!/bin/bash

. ./get_statistics.sh

echo "INSERT INTO \`mem_usage\` (\`Used\`,\`Free\`) VALUES (`mem_used`,`mem_free`);" | docker-compose exec -T db mysql -uroot -proot statistics
echo "INSERT INTO \`disk_usage\` (\`Used\`,\`Free\`) VALUES (`disk_used`,`disk_free`);" | docker-compose exec -T db mysql -uroot -proot statistics
echo "INSERT INTO \`cpu_usage\` (\`Usage\`) VALUES (`cpu_usage`);" | docker-compose exec -T db mysql -uroot -proot statistics


