# log
> __2014年 05月 15日 星期四 21:30:49 CST__
### 修改更新源
* /etc/apt/sources.list 如:
* deb ftp://ftp.cn.debian.org/debian/ wheezy main contrib non-free
* deb-src ftp://ftp.cn.debian.org/debian/ wheezy main contrib non-free

### 检测最快的更新源，存为 /etc/apt/sources.list.d/apt-spy.list
`apt-spy -d wheezy -a asia -t 5`

### 下载&验证服务器签证
```bash
gpg --keyserver pgpkeys.mit.edu --recv-key 6FB2A1C265FFB764
gpg -a --export 8B48AD6246925553 |  apt-key add -
```

> __2014年 05月 15日 星期四 22:36:09 CST__
###   screen reload
` :source ~/.screenrc`

### 删除-foo
```
rm -- -foo
rm ./-foo
```

### 获取mem cpu信息 /proc/$PID/stat
`ps -p  1577 -o %cpu,%mem,cmd`


> __2014年 05月 24日 星期六 21:32:18 CST__
### debian的screen中bash-completion，不工作
1. 检测screenrc设置，去掉vbell，还是不行
2. cygwin中的screen工作正常，检查screen版本，重新下载编译，但没用
3. 检查bash-completion版本，并重新安装，没用
4. 检测bashrc中bash-completion设置，对比cygwin中，source过git-completion（以前为了加快bash启动速度）
确定为debian中未导入bash-completion，将之添加到aliases中，方便管理



> __2014年 06月 01日 星期日 21:19:12 CST__
### cocos2d-x开发相关
#### 环境
- vs2012+cocos2d-x
- eclipse+cocos2d-x
- sublime text 2 + quick-cocos2d-x
#### windows下开发，vs2012或sublime text 2为编码、调试环境，c++为平台连接，lua开发界面和游戏逻辑
