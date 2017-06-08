#! /usr/bin/bash
#   by walker
VERSION='v0.0.3 by walker'
MSI_DIR='/e/zmy/analyseServer/analyseServer/Release/msi'
CURR_DIR=$(pwd)
TOMCAT='/d/xampp/tomcat/bin/startup.bat'
CONFIG_FILE='/d/xampp/tomcat/webapps/iics/WEB-INF/classes/spring-hibernate.xml'
OLD_FILE='/d/2017-06-01.txt'
DATA_FILE="/d/"$(date +%Y-%m-%d)".txt" 
function usage()
{
	cat <<EOF |GREP_COLOR='01;32' grep --color=always . 
Usage:
	./rock.sh [op] [file]
	分析服务器测试用自动脚本[卸载/安装/修改/克隆/部署/启动/停止/日志分析]
Op:
            无参数时，同 -a
    -h      显示usage
    -v      版本信息
    [file]  统计日志
    -e      统计日志错误
    -a      顺序执行命令，-e/l
    -t      修改配置 & 重启tomcat
    -k      杀死进程
    -i      卸载并安装
    -c      克隆副本
    -1      启动所有vaServer64
    -2      启动所有analyserServer64
    -r      等于 -1 & -2
    -p      已启动副本进程
EOF
}


function mkcopy()
{
	BANKCODE=( 0501 0901 0401 1602 1502 1601 )
	SRC_DIR='/c/Program Files/Inforun/analyseServer'
	URL='http://192.168.1.31:8080/inforunws/service/rest'
	LOG_DIR='D:/Log'
	PORT=64000
	notify_PORT=8000
	HEARTBEAT=30
	COUNT=0
	[ -d $LOG_DIR ] || mkdir -p $LOG_DIR
	[ -d build ] || mkdir -p build
	echo -e "源目录:\t\t$SRC_DIR"
	echo -e "日志目录：\t$LOG_DIR"
	echo -e "心跳间隔：\t$HEARTBEAT""s"
	echo -e "内控地址：\t$URL"
	echo -e "所有bankcode \t[${BANKCODE[*]}]"
	echo -e "bankCode\t算法端口\t内控通知端口\t日志路径"

	[ -d build ] && rm -rf build/* || mkdir build
	for arg in ${BANKCODE[*]}
	do
		(( COUNT += 1 ))
		[ -d "$SRC_DIR" ] && cp -R "$SRC_DIR" build/$arg
		sed -i 's#\(.*\).path =.*#\1.path = '$LOG_DIR'/'$arg'.rg.log#'          build/$arg/log_rg.properties
		sed -i 's#\(.*\).path =.*#\1.path = '$LOG_DIR'/'$arg'.va.log#'          build/$arg/log_va.properties
		sed -i 's#<port>64000</port>#<port>'$(($PORT + $COUNT))'</port>#'       build/$arg/vaServer.xml
		sed -i 's#<heartbeatInterval>.*</heartbeatInterval>#<heartbeatInterval>'$HEARTBEAT'</heartbeatInterval>#gi'                             build/$arg/vaServer.xml
		sed -i 's#<port>64000</port>#<port>'$(($PORT + $COUNT))'</port>#'       build/$arg/analyseServer64.xml
		sed -i 's#<port>8000</port>#<port>'$(($notify_PORT + $COUNT))'</port>#' build/$arg/analyseServer64.xml
		sed -i 's#<bankCode>.*</bankCode>#<bankCode>'$arg'</bankCode>#'         build/$arg/analyseServer64.xml
		sed -i 's#<url>.*</url>#<url>'$URL'</url>#'                             build/$arg/analyseServer64.xml
		sed -i 's#<heartBeatInterval>.*</heartBeatInterval>#<heartBeatInterval>'$HEARTBEAT'</heartBeatInterval>#gi'                             build/$arg/analyseServer64.xml

		echo -e $arg"\t\t"$(($PORT + $COUNT))"\t\t"$(($notify_PORT + $COUNT))"\t\t$LOG_DIR/$arg.rg.log"
	done
}
function tomcat()
{
	echo '修改配置' $DATA_FILE|grep --color=always . && cp $OLD_FILE $DATA_FILE && sed -i 's#|\(2017/[^|]*\)#|'"$(date +%Y/%m/%d --date='1 day ago')"'#' $DATA_FILE
	echo '修改配置' $CONFIG_FILE '核心数据解析(5min later)'|grep --color=always . && [ -f ${CONFIG_FILE}.bak ] && cp $CONFIG_FILE{.bak,} && sed -i 's#\(property name="cronExpression" value="\)\(03 02 01\)#\1'"$(date +%S" "%M" "%H --date='5 minutes')"'#' $CONFIG_FILE || cp $CONFIG_FILE{,.bak} && sed -i 's#\(property name="cronExpression" value="\)\(03 02 01\)#\1'"$(date +%S" "%M" "%H --date='5 minutes')"'#' $CONFIG_FILE
	echo '重启tomcat' | grep --color=always . && eval $(tasklist.exe |grep -ia 'java.exe'|awk '{print "-PID "$2}'|tr "\n" " " |xargs.exe -i echo {}|sed 's/^/taskkill -F /') && $TOMCAT 
	echo "等待tomcat完全启动(20s)"| grep --color=always . && sleep 20
}
function allinone()
{
	echo '杀死进程[vaServer64&analyserServer64]' | grep --color=always . && eval $(tasklist.exe |grep -iaE 'analyseServer64.exe|vaServer64.exe'|awk '{print "-PID "$2}'|tr "\n" " " |xargs.exe -i echo {}|sed 's/^/taskkill -F /')
	echo '卸载并安装' |grep --color=always . && msiexec.exe -q -x $(reg query "HKLM\SOFTWARE\Inforun\analyseServer"|grep ProductCode|awk '{print $3}') &> /dev/null 
	(cd $MSI_DIR && ls -t *.msi|sed -n '1p'|xargs -i msiexec.exe -q -i {})
	echo '克隆副本' | grep --color=always . && mkcopy
	echo '启动所有vaServer64' | grep --color=always . && eval $(find . -name 'vaServer64.exe'|sed 's#/[^/]*$##;s/\.//;s#^#(cd '$CURR_DIR'#g;s#$# \&\& ./vaServer64.exe \&> /dev/null \&)#'|tr "\n" " "|sed 's#) (#) \&\& (#g') 
	echo '启动所有analyserServer64' | grep --color=always . && eval $(find . -name 'analyseServer64.exe'|sed 's#/[^/]*$##;s/\.//;s#^#(cd '$CURR_DIR'#g;s#$# \&\& ./analyseServer64.exe \&> /dev/null \&)#'|tr "\n" " "|sed 's#) (#) \&\& (#g')
	echo '已启动副本进程' | grep --color=always . && ps -ef |grep --color=always 'build.*64'
}

[ $# == 0 ] && usage && $0 -k && tomcat && allinone && exit

until [ -z "$1" ]
do
	[ ""$1 == "-h" ] && usage
	[ ""$1 == "-a" ] && allinone 
	[ ""$1 == "-t" ] && tomcat
	[ ""$1 == "-v" ] && echo -e 'rock' $VERSION | grep --color=always .

	[ ""$1 == "-k" ] && echo '杀死进程[vaServer64&analyserServer64]'| grep --color=always . && eval $(tasklist.exe |grep -ia er64.exe|awk '{print "-PID "$2}'|tr "\n" " " |xargs.exe -i echo {}|sed 's/^/taskkill -F /')
	if [[ ""$1 == "-i" ]];then
		echo '卸载并安装'| grep --color=always . && msiexec.exe -q -x $(reg query "HKLM\SOFTWARE\Inforun\analyseServer"|grep ProductCode|awk '{print $3}') &> /dev/null 
		(cd $MSI_DIR && ls -t *.msi|sed -n '1p'|xargs -i msiexec.exe -q -i {})
	fi
	[ ""$1 == "-c" ] && echo '克隆副本' | grep --color=always . && mkcopy
	[ ""$1 == "-1" ] && echo '启动所有vaServer64' | grep --color=always . && eval $(find . -name 'vaServer64.exe'|sed 's#/[^/]*$##;s/\.//;s#^#(cd '$CURR_DIR'#g;s#$# \&\& ./vaServer64.exe \&> /dev/null \&)#'|tr "\n" " "|sed 's#) (#) \&\& (#g') 
	[ ""$1 == "-2" ] && echo '启动所有analyserServer64' | grep --color=always . && eval $(find . -name 'analyseServer64.exe'|sed 's#/[^/]*$##;s/\.//;s#^#(cd '$CURR_DIR'#g;s#$# \&\& ./analyseServer64.exe \&> /dev/null \&)#'|tr "\n" " "|sed 's#) (#) \&\& (#g')
	[ ""$1 == "-r" ] && ($0 -1 ; sleep 3; $0 -2)
	[ ""$1 == "-p" ] && echo '已启动副本进程' | grep --color=always . && ps -ef |grep --color=always 'build.*64'
	[ ""$1 == "-e" ] && echo '统计日志错误' | grep --color=always . && (while true ; do grep -n '\[E\]' /d/log/*.rg.log|sed 's/:.*:.*#/#/g'|sed 's/失败:.*/失败:/g;s/id:.*/id:/g'|sort|uniq -c| GREP_COLOR='01;32' grep --color=always '#.*' ; sleep 3; echo ; done)
	#	[ ""$1 == "-l" ] && echo '统计日志'|grep --color=always . && (while true ; do grep -nE 'waiting|推送|数据|上传|缓存|任务|报警|计划' /d/log/*.rg.log|sed 's/:.*:.*#/#/g'|awk -F[:,] '{print $1}'|sort|uniq -c|grep --color=always -E 'waiting|推送|数据|上传|缓存|任务|报警|计划'|GREP_COLOR='01;32' grep --color=always -E 'waiting|$'; echo ; sleep 3; done) 
	[ -f $1 ] && echo '统计日志' $1|GREP_COLOR='01;32' grep --color=always . && grep -E 'waiting|推送|数据|上传|缓存|任务|报警|计划' $1|sed 's/.*#//g'|awk -F[:,] '{print $1}'|sort|uniq -c|grep --color=always -E 'waiting|推送|数据|上传|缓存|任务|报警|计划'

	shift
done
