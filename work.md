## 新版本更新注意：
    1. 配置文件格式变化，测试需根据旧配置修改，见图片注释
    2. 内控配置中json库改为 jsonProvider2
## 匹配中文：
    - [\u4e00-\u9fa5]
## shell单行(部分需要管理员权限)：

### webapi test:
    curl -l -H "Content-type: application/json" -X POST -d @./json_body.json http://192.168.1.31:8080/iics/service/rest/alarm/uploadFailedNotifyResult

    
### kill进程：
    eval $(tasklist.exe |grep -ia er64.exe|awk '{print "-PID "$2}'|tr "\n" " " |xargs.exe -i echo {}|sed 's/^/taskkill /')
    eval $(tasklist.exe |grep -ia er64.exe|grep analyseServer|awk '{print "-PID "$2}'|tr "\n" " " |xargs.exe -i echo {}|sed 's/^/taskkill /')
### 卸载并安装：
    msiexec.exe -q -x $(reg query "HKLM\SOFTWARE\Inforun\analyseServer"|grep ProductCode|awk '{print $3}') ; (cd /e/zmy/analyseServer/analyseServer/Release/msi && ls -t *.msi|sed -n '1p'|xargs -i msiexec.exe -q -i {})
### 启动程序：
    eval $(find . -name '*64.exe'|grep vaS|sed 's#/vaS.*##g;s#\./#/#g;s#^#(cd /e/zmy/analyseServer/analyseServer/analyseServer/tools#g;s#$# \&\& ./vaServer64.exe \& >\& /dev/null)#'|tr "\n" " "|sed 's#) (#) \&\& (#g') 
    eval $(find . -name '*64.exe'|grep analy|sed 's#/ana.*##g;s#\./#/#g;s#^#(cd /e/zmy/analyseServer/analyseServer/analyseServer/tools#g;s#$# \&\& ./analyseServer64.exe \& >\& /dev/null)#'|tr "\n" " "|sed 's#) (#) \&\& (#g')
### sftp同步最新文件:
    (echo "cd /d/ftpInforun/businessData";echo "ls -lt")|sftp -b - cs@192.168.1.100 |grep -v 'sftp>'|head -1|sed 's/.* //g;s#^#cd /d/ftpInforun/businessData\nget #g'|sftp -b - cs@192.168.1.100
### rsync：
    - 远程到本地
        rsync -ravzP -e ssh cs@inforun:/home/cs/test/  test
        rsync -ravzP -e 'ssh -p 2222' cs@inforun:/home/cs/test/  test
    - 本地到远程
        rsync -ravzP -e ssh test cs@inforun:/home/cs/test/
        rsync -ravzP -e 'ssh -p 2222' test cs@inforun:/home/cs/test/

### tcp消息发送：
    echo '{"messageType":222}'|nc 127.0.0.1 7901;echo '{"messageType":222}'|nc 127.0.0.1 7902;echo '{"messageType":222}'|nc 127.0.0.1 7903;echo '{"messageType":222}'|nc 127.0.0.1 7904;echo '{"messageType":222}'|nc 127.0.0.1 7905;echo '{"messageType":222}'|nc 127.0.0.1 7906
    echo '{"messageType":222}'|socat - TCP:localhost:7901 && echo '{"messageType":222}'|socat - TCP:localhost:7902 && echo '{"messageType":222}'|socat - TCP:localhost:7903 && echo '{"messageType":222}'|socat - TCP:localhost:7904 && echo '{"messageType":222}'|socat - TCP:localhost:7905 && echo '{"messageType":222}'|socat - TCP:localhost:7906
### 格式化打印：
    cat /c/Users/walker/Desktop/1.txt|while read line;do echo $line|sed 's/、/\n/g'|awk '{printf "%04d\n", $1}'|sort -n|uniq|tr "\n" " ";echo;done
    cat /e/zmy/analyseServer/analyseServer/analyseServer/riskpoint.xml|grep trans|sed 's#</.*##;s#.*>##'|while read line; do echo $line|sed 's/,/ /g'; done |tr " " "\n"|sort -n|uniq -c|sort -n
### 消息统计：
    ls /d/log/*.va.log|while read line; do echo $line|grep .;grep -E '消息 [发送|解析]' $line|awk -F# '{print $2}'|sed 's/].*//g'|sort|uniq -c; done
### 删掉彩色
    - sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"
    - sed "s,\x1B\[[0-9;]*[a-zA-Z],,g"
### 查看用的最多的命令
    - history |awk '{print $2}'|sort|uniq -c|sort -rn|head -10
### 行列转换：
    - awk -F " +" '{for(i=1;i<=NF;i++) a[i,NR]=$i}END{for(i=1;i<=NF;i++) {for(j=1;j<=NR;j++) printf a[i,j] " ";print ""}}' urfile
### 计时：
    - while true; do END=$(date +%s --date='17:30:00'); echo "离17:30还有["$(( $END - $(date +%s) ))"]秒";sleep 1;done
    - COUNT=0; while true;do echo $(( COUNT+=1 )) $(date +%T);sleep 30;done
## 统计：
    - 报警+失败 与 核心数据 对比：
        comm -3 <(grep '"bussinessCoreId": ' ./log.rg.log|grep -v '"bussinessCoreId": 0,'|sed 's/.*bussinessCoreId": //g;s/,//g'|sort|uniq) <(grep businessList ./log.rg.log|sed 's/,/\n/g'|grep 'bussinessId'|sed 's/.*"bussinessId"://g'|sort|uniq)
    - 报警 与 核心数据 对比：
        comm -3 <(grep -n '数据上传 .*Alarm' ./log.rg.log|awk -F: '{print $1}'|sed 's/\(.*\)/\1+5/g'|bc|tr "\n" " "|sed 's/ /p;/g'|sed 's/;$//'|xargs.exe -i sed -n ''{}'' ./log.rg.log |grep -v '"bussinessCoreId": 0,'|sed 's/.*"bussinessCoreId": //;s/,//g'|sort|uniq) <(grep businessList ./log.rg.log|sed 's/,/\n/g'|grep 'bussinessId'|sed 's/.*"bussinessId"://g'|sort|uniq)
    - 是否创建任务：    
        echo '5912377'|tr "\n" "|"|sed 's/|$//'|xargs.exe -i grep --color -E ''{}'' <(grep '任务 创建' log.rg.log)|wc -l
    - 获取失败上传行号：
        grep -n '数据上传 FailedNotify' ./log.rg.log
    - 失败任务是否最后分析成功：
        grep -n '数据上传 .*Alarm' ./log.rg.log|awk -F: '{print $1}'|sed 's/\(.*\)/\1+5/g'|bc|sort|uniq|xargs.exe -i sed -n ''{}'p' ./log.rg.log|sed 's/.*"bussinessCoreId": //;s/,//g'
        grep -n '数据上传 FailedNotify' ./log.rg.log|awk -F: '{print $1}'|sed 's/\(.*\)/\1+2/g'|bc|sort|uniq|xargs.exe -i sed -n ''{}'p' ./log.rg.log|sed 's/.*"bussinessCoreId": //;s/,//g'
    - 新增报警成功数：
        count=0;stat=0;while true ; do  (( count++ )); last=$stat;echo -e "数据上传\n"|grep . --color; stat=$(grep -c 数据上传 /d/log/*.rg.log|tr "\n" ":"|sed 's/[^:]*log:/+/g;s/^+//;s/://g;'|xargs.exe -i echo '({})'|bc); echo $last $stat $(( $stat-$last ))" "$count;echo 'sleep for 3 sec';sleep 3; done
## SQL:
    1. 更新上下班时间(2min)
    - update t_work_time twt set twt.begin_date=sysdate,twt.end_date= sysdate+2,twt.work_begin_time=to_char(sysdate+2/24/60,'hh24:mi'),twt.work_end_time=to_char(sysdate+12/24/60,'hh24:mi'),twt.rest_starttime =to_char(sysdate+5/24/60,'hh24:mi'),twt.rest_endtime =to_char(sysdate+10/24/60,'hh24:mi')  where twt.bank_id in ('4921','4348580','4348581','4348582','4348583','4353450');
      select * from t_work_time  twt  left join t_bank tb on twt.bank_id=tb.id  where tb.bank_code in ('0501','0901','0401','1602','1502','1601');
    2. 修改分析 ip port
    - select * from t_facilities tf inner join t_bank tb on tf.bank_id=tb.id where tf.ip='192.168.1.31' and tb.bank_code in ('0501','0901','0401','1602','1502','1601');
    - select * from t_bank tb where tb.bank_code in ('0501','0901','0401','1602','1502','1601');
    - select * from t_facilities tf where tf.ip='192.168.1.31' for update
    - select tf.f_code, tf.ip , tf.port from t_facilities tf inner join t_bank tb on tf.bank_id=tb.id where tf.ip='192.168.1.31' and tb.bank_code in ('0401','0501','0901','1502','1601','1602')  for update
## 服务：
    1. 安装为服务:
        - 定时拉取,监听通知
        - curl(下载), msiexec(安装,更新),启动,安装日志上传
        - 强制更新
        - 日志上传, db记录
    2. 安装卸载(管理员权限 静默)
        msiexec /i analyseServer-x64-1.2.42.msi /qb /l+ install.log
        msiexec /i analyseServer-x64-1.2.42.msi /qr /l+ install.log
        msiexec /i analyseServer-x64-1.2.42.msi /passive /l+ install.log
        msiexec /x analyseServer-x64-1.2.42.msi /qb /l+ install.log
        msiexec /x analyseServer-x64-1.2.42.msi /qr /l+ install.log
        msiexec /x analyseServer-x64-1.2.42.msi /passive /l+ install.log
## include去重：
    - g++ -H  foo.C |& awk '{print $2}' | sort | uniq -c | grep -v '      1 '
## gogs:
	- mysql 建表：
		DROP DATABASE IF EXISTS gogs;
		CREATE DATABASE IF NOT EXISTS gogs CHARACTER SET utf8 COLLATE utf8_general_ci;
	- git subtree:
		git clone cs@192.168.1.100:inforun/analyseServer.git
		cd analyseServer
		git subtree split -P boost_1_59_0 -b boost-lib		# 简单split 目录为一个分支
		mkdir ../boost && cd ../boost
		git init
		git pull ../analyseServer boost-lib	
		git tag |xargs -i git tag -d {}
		git filter-branch --subdirectory-filter analyseServer -- --all	# split
		git remote add -f poco-lib cs@192.168.1.100:inforun/poco.git
		git subtree add -P poco poco-lib master
		git subtree pull -P poco poco-lib
		git subtree push -P poco poco-lib master
		git subtree split --rejoin -P poco --branch new_poco
		git push poco new_poco:master
	- json 序列化：
        :%s/\(.*\)/j["\1"] = data.\1;/g
        :%s/\(.*\)/if (j.find("\1") != j.end())\r{\rdata.\1 = j["\1"];\r}\r/g
        
## 搜索：
	1. taskid
		- 发送信息:TaskID:.*thumbnail.jpg
		- 任务 结果[上报]	[alarm]:	 taskID[
		- thumbnail.jpg
		
## 配置：
	D:\xampp\tomcat\webapps\iics\WEB-INF\classes\config.properties
		jdbc.url=jdbc:oracle:thin:@192.168.1.100:1521:BANK4
		jdbc.username=dev
		jdbc.password=dev321
		versionUrl=http://192.168.1.31:8080/doc/
		versionPath=E:\\zmy\\analyseServer\\analyseServer\\Release\\msi
		pushDataTime=60000
	D:\xampp\tomcat\webapps\iics\WEB-INF\classes\spring-hibernate.xml
			<property name="cronExpression" value="0 53 12 * * ?" />
            
### 核心数据推送：
	1. 核心数据文件更名为 当前日期
	2. 核心数据文件 日期替换为 昨天日期
	3. 修改 tomcat 文件config.properties 中推送时间为解析后一分钟 pushDataTime=60000 
	4. 修改 tomcat 文件spring-hibernate.xml 中 cronExpression 的value 为 当前时间 之后 几分钟
	5. 启动 tomcat
	6. 启动 vaServer
	7. 清理 redis 数据 flushdatabase 或者 redis-cli flushall
	8. 启动 analyseServer