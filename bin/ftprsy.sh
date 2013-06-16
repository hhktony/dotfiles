#!/usr/bin/env bash

if [ $# -ne 3 -a $# -ne 4 ]; then
	printf "\n\tUsage: $0 ipaddr port username [password]\n\n"
	exit 1
fi

ipaddr=$1
port=$2
ftp_username=$3

echo "${ipaddr} ${port} $ftp_username"

if [ -z $4 ]; then
	ftp_password="nopassword"
else
	ftp_password=$4
fi

config_file="$HOME/.upload_list"

if [ ! -f $config_file ]; then
    touch $config_file
fi

line_num=`awk 'END {print NR}' $config_file` # 取行总数
line_num=`expr $line_num + 1`

printf "Upload ... <--------------------\n"
cout=1
while [ $cout -ne $line_num ]
do
	src_path=`awk 'NR=="'$cout'" {print}' $config_file | awk '{print $1}'` # 取第 i 行 第一列
    echo "${src_path}" | grep "^#" &> /dev/null
    if [ $? = 0 ]; then
	    cout=$(($cout + 1))
        continue
    fi

	src_file=`basename $src_path`
	des_dir=`awk 'NR=="'$cout'" {print}' $config_file | awk '{print $2}'`

	echo "src_path=$src_path, des=$des_dir"

lftp << EOF
open  ${ipaddr} -p ${port} -u ${ftp_username},${ftp_password}
put -O ${des_dir} ${src_path}
chmod +x ${des_dir}/$src_file
bye
EOF

	cout=$(($cout + 1))
done

printf "\nFinished <--------------------\n"
