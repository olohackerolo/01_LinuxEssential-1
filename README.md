Linux Essential 과정 정리

Linux 기초 관리자 과정

########################
제 01장. 리눅스 소개
########################

자격증
* 민간 자격증
* 국가 자격증
	리눅스 마스터 1급/2급
	네트워크 관리사 1급/2급
	
	정보처리기사
* 국제 공인 자격증
	AWS SA
	RedHat RHCSA/RHCE
	LPIC

[참고] 복제된 운영체제에서 변경 사항
* 호스트 이름
	# hostnamectl
	# hostnamectl set-hostname server2.example.com
* IP 설정
	# nm-connection-editor
	# nmcli connection up ens160


########################
제 02장 리눅스 설치
########################


########################
제 03장 리눅스 환경 설정
########################

리눅스의 선수지식
* Runlevel == Target
	runlevel 3 == multi-user.target
	runlevel 5 == graphical.target

	# systemctl isolate multi-user.target|graphical.target
	# systemctl set-default multi-user.target|graphical.target

* 서비스 기동
	# systemctl enable|disable firewalld
	# systemctl start|stop firewalld

* 제어 문자(Control Character)
	<CTRL + C>, <CTRL + D>

* 도움말과 암호변경
	man CMD
		# man ls
		# man -k calendar
		# man -f passwd
		# man -s 5 passwd
		
		[참고] 명령어 옵션 확인
		# ls --help 
		# man ls
	passwd CMD
		# passwd fedora

########################
제 04장 리눅스 기본 정보 확인
########################

시스템 기본 정보 확인
	uname CMD
		# uname -a 
		# cat /etc/redhat-release 
		
		[참고] redhat documentation
		https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8
	date CMD
		# date 08301300
		# date +%m%d
		
		[실무예] NTP(Network Time Protocol) 서버에 시간 동기화
		# vi /etc/chrony.conf
		server time.bora.net iburst
		# systemctl stop chronyd
		# systemctl start chronyd
	cal CMD

########################
제 05장 파일 및 디렉토리 관리
########################

디렉토리 이동 관련 명령어
	[참고] 파일시스템 기본 구조
	# man 7 hier
	
	pwd CMD
		[참고] PS1 변수($HOME/.bashrc)
		# export PS1='[\u@\h \w]\$ '
	cd CMD
		경로(Path)
		* 상대경로(Relative Path) # cd dir1
		* 절대경로(Absolute Path) # cd /dir1

		[참고] 자신의 홈디렉토리 이동
		# cd
		# cd ~
		# cd $HOME
		
		[참고] 지정된 사용자 홈디렉토리 이동
		# cd ~fedora

		[실무예] 이전 디렉토리로 이동하기
		# cd -

		[실무예] 옆에 있는 디렉토리로 이동하기
		# cd ../dir2

디렉토리 관리 명령어
	ls CMD
		# ls -l dir1
		# ls -ld dir1
		OPTIONS: -l, -d, -R, -a, -i, -h, -t, -r
				
		[참고] alias 
		(선언) # alias ls='ls -l | grep "^-"'
		(확인) # alias 
		(해제) # unalias ls
		
		[실무예] 실무에서 많이 사용되는 ls CMD
		# cd /Log_dir
		# ls -altr
	mkdir CMD
		# mkdir -p dir1/dir2
	rmdir CMD
		# rm -rf dir1

파일 관리 명령어
	touch CMD
		# touch -t 08301300 file1
	cp CMD
		# cp file1 file2
		# cp file1 dir1
		# cp -r dir1 dir2
		OPTIONS: -r, -i, -f, -p, -a 
		
		[실무예] 설정 파일을 백업하는 경우
		# cp -p httpd.conf httpd.conf.orig
		# cp -a /src /src.orig

		[실무예] 로그 파일 비우기
		# cp /dev/null file.log
		# cat /dev/null > file.log
		# > file.log
	mv CMD
		# mv file1 file2
		# mv file1 dir1
		# mv dir1 dir2
		OPTIONS: -i, -f
		
		[참고] 와일드 캐릭터(Wild Character)
		*  ?  {}  []
	rm CMD
		# rm -rf dir1
		
		[실무예] rm 명령어로 지운 파일 복원하기
		(TUI) extundelete CMD
		(GUI) TestDisk 툴

파일 내용 확인 명령어
	cat CMD
		# cat -n file1
		# cat file1 file2 > file3
	more CMD
		# CMD | more
		# ps -ef | more
		# cat /etc/services | more
		# netstat -an | more
		# systemctl list-unit-files 
	head CMD
		[실무예] pps/nstat 엘리어스 만들기
		# alias pps='ps -ef | head -1 ; ps -ef | grep $1'
		# alias nstate='netstat -antup | head -2 ; netstat -antup | grep $1'
	tail CMD
		# top 
		# tail -f /var/log/messages
		
		# tail -f /var/log/messages | egrep -i 'warn|error|fail|crit|alert|emerg'
		# tail -f /var/log/messages /var/log/secure
	
		[참고] telnet 서비스 기동하기
		# yum install tenlet telnet-server
		# systemctl enable --now telnet.socket
	
기타 관리용 명령어
	wc CMD
		[참고] 데이터 수집(Data Gathering)
		# ps -ef | tail -n +2 | wc -l
		# ps -ef | grep httpd | wc -l
		# cat /etc/passwd | wc -l
		# rpm -qa | wc -l
		# df -k / | tail -1 | awk '{print $5}'
		# cat /var/log/messages | grep 'Jan 19' | grep 'Started Telnet Server' | wc -l
	
	su CMD
		# su root
		# su - root
	sudo CMD(/etc/sudoers, /etc/sudoers.d/*)
		# sudo CMD
		# sudo -l
		# sudo -i
	
	id CMD
	groups CMD
	
	last CMD(/var/log/wtmp)
		# last -i
		# last -f /var/log/wtmp.20230128
	lastlog(/var/log/lastlog)
	lastb CMD(/var/log/btmp)
	who CMD(/var/run/utmp)
	w CMD
		[참고] 모니터링 구문
		while true
		do
			echo "---`date`---"
			CMD
			sleep 2
		done
		
		[참고] watch CMD
	
	exit CMD

########################
제 06장 파일 종류
########################

파일 종류
* 일반 파일(Regular File)
* 디렉토리 파일(Directory File)
* 링크 파일(Link File)
	* 하드 링크 파일(Hard Link File)
		# ln file1 file2
	* 심볼릭 링크 파일(Symbolic Link File)
		# ln -s file1 file2
* 장치 파일(Device)
	* 블록 장치 파일(Block Device File)
	* 캐릭터 장치 파일(Character Device File)

########################
제 07장 파일 속성 관리
########################

chown CMD
	# chown -R fedora:fedora /home/fedora
chgrp CMD
chmod CMD
	퍼미션 변경
	* 심볼릭 모드(Symbolic Mode) # chmod u+x file1
	* 옥탈 모드(Octal Mode)		 # chmod 755 file1
	파일 & 디렉토리 퍼미션 의미
	* 파일(r / w / x)
	* 디렉토리(r(ls -l CMD) / w(생성/삭제) / x(cd CMD))
	퍼미션 적용 순서
	* UID check -> GIDs check -> other
	umask CMD(002 -> 022 -> 027)
	* (관리자) /etc/bashrc
	* (사용자) $HOME/.bashrc

########################
제 08장 VI/VIM 편집기
########################

VI 편집기 모드
* 명령 모드(Command/Edit Mode)
	이동, 삭제, 실행취소/재실행, 복사, ...
* 입력 모드(Insert/Input Mode)
	i, a, o/O
* 최하위행 모드(Last Line/Ex Mode)
	저장&나가기, 검색, 검색&바꾸기, 복사/이동하기

VI 편집기 환경파일
* $HOME/.vimrc
	set nu
	set ai
	set ts=4 sw=4

########################
제 09장 사용자와 통신할 때 사용하는 명령어
########################

mail/mailx CMD
	# mailx -s '[  OK  ] server1' admin@example.com < /root/report.txt
wall CMD
	# wall < /etc/MESS/work.txt
	
	[참고] 긴급 작업 절차
	# touch /etc/nologin 
	# wall < /etc/MESS/work.txt
	...
	# fuser -cu /home
	# fuser -ck /home
	작업 진행
	# rm -f /etc/nologin 

########################
제 10장 관리자가 알아두면 유용한 명령어
########################
cmp/diff CMD
	[실무예] 설정 파일 비교
	# diff httpd.conf httpd.conf.OLD
	
	[실무예] 디렉토리 마이그레이션 종료 후 비교
	# find /was1 | wc -l ; find /was2 | wc -l
	# diff -r /was1 /was2

sort CMD
	# CMD | sort -k 3 -n
	# CMD | sort -k 3 -nr

	[실무예] 파일/파일시스템 사용량 점검 
	# df -k
	# du -sk /var
	# cd /var ; du -sk * | sort -nr | more

file CMD
	# file *

########################
제 11장 검색 관련 명령어
########################
grep CMD
	grep OPTIONS 'PATTERN' file1
	* OPTIONS: -i, -l, -v, -r, -n, --color, -A
	* PATTERN: *  .  ^root  root$  [abc] [a-c] [^a]
	
	CMD | grep root
	# cat /etc/passwd | grep root
	# rpm -qa | grep httpd
	# ps -ef | grep rsyslogd
	# systemctl list-unit-files | grep ssh
	# netstat -antup | grep :22

	[실무예] 로그 파일 점검 스크립트
	# alias chklog='cat $1 | egrep -i "warn|error|fail|crit|alert|emerg"'
	# vi /root/bin/chklog.sh
----------------------------------------	
#!/bin/bash

if [ $# -ne 1 ] ; then
    echo "Usage: $0 <logfile>"
    exit 1
fi

export LANG=C
RE1=$(date +'%b')
RE2=$(date +'%d')
if [ $RE2 -le 9 ] ; then
	RE2=$(echo $RE2 | cut -c2-)
	RE2=" $RE2"
fi
cat $1 | egrep "$RE1 $RE2" | egrep -i --color 'warn|errror|fail|crit|alert|emerg' 
----------------------------------------

find CMD
	# find / -name core -type f
	# find / -user fedora -group fedora
	# find / -mtime -7|7|+7
	# find / -size -30M|30M|+30M
	# find / -perm -755|755
	# find / -name core -type f -exec CMD {} \;
	
	[실무예] 오래된 로그 파일 삭제(find CMD + rm CMD + crontab CMD)
	# find /LogDir -name "*.log" -type f -mtime +30 -exec rm -f {} \;

	[실무예] 갑자기 파일시스템 풀(full) 난 경우(-mtime)
	df CMD + du CMD + find CMD + lsof CMD
	# df -k
	# du -sk /var 
	# cd /var ; du -sk * | sort -nr | more
	# find /var -mtime -2 -size +1G -type f
	-> /var/log/server.log
	# lsof /var/log/server.log

	[실무예] 에러 메세지 검색
	(소스 코드 0) 	# find /src -type f -exec grep -l 'Server Error' {} \;
				# grep -r 'Server Error' /src
	(소스 코드 X) 
		site:redhat.com "Server Error"
		site:redhat.com "Server Error" AND "vmware" AND "windows 10"
		가상화 .pdf

########################
제 12장 압축과 아카이빙
########################

압축(Compress)
	gzip/gunzip CMD
		# gzip file1
		# gunzip -c file1.gz
		# gunzip file1.gz
	bzip2/bunzip2 CMD
		# bzip2 file1
		# bunzip2 -c file1.bz2
		# bunzip2 file1.bz2
	xz/unxz CMD
		# xz file1
		# unxz -c file1.xz
		# unxz file1.xz

아카이빙(Archive)
	tar CMD
		# tar cvf file.tar file1 file2
		# tar tvf file.tar
		# tar xvf file.tar
		
압축 + 아카이빙
	tar CMD
		(tar CMD + gzip CMD)
		# tar cvzf file.tar.gz file1 file2
		# tar tvzf file.tar.gz
		# tar xvzf file.tar.gz
		
		(tar CMD + bzip2 CMD)
		# tar cvjf file.tar.bz2 file1 file2
		# tar tvjf file.tar.bz2
		# tar xvjf file.tar.bz2

		(tar CMD + xz CMD)
		# tar cvJf file.tar.xz file1 file2
		# tar tvJf file.tar.xz
		# tar xvJf file.tar.xz		
	jar CMD
		# jar cvf file.jar file1 file2
		# jar tvf file.jar
		# jar xvf file.jar	
	zip/unzip CMD
		# zip file.zip file1 file2
		# unzip -l file.zip
		# unzip file.zip 

########################
제 13장 배시쉘의 특성
########################

리다이렉션(Redirection)
	fd
	----------------------
	0	stdin(keyboard)
	1	stdout(Screen)
	2	stderr(Screen)
	----------------------

	입력 리다이렉션(Redirection stdin) 	# wall < /etc/MESS/work.txt
	출력 리다이렉션(Redirection stdout)	# ls -l > lsfile.txt
	에러 리다이렉션(Redirection stderr)	# ls -l /test /nodir > list.txt 2>&1
	
	[실무예] 스크립트 로그 파일 생성
	# ./script.sh > script.log 2>&1
	
	[실무예] 출력 내용이 긴 명령 수행시 출력 화면 분석
	# ./configure > config.log 2>&1
	
	[실무예] 일반사용자가 명령 수행시 에러메세지를 지우는 경우
	$ find / -name core -type f 2>/dev/null 

파이프(Pipe)
	# CMD | more
	# CMD | grep inetd
	# CMD | CMD | ...

	[실무예] 모니터링 구문 + 데이터 수집(CMD | tee -a httpd.cnt)
	while true
	do
		ps -ef | grep httpd | wc -l | tee -a httpd.cnt
		sleep 2
	done

	[실무예] 여러 터미널 화면을 공유하는 경우
	# script -a /dev/null | tee /dev/pts/1 | tee /dev/pts/2

배시쉘 기능(Shell Function)
	# set -o 
	# set -o vi
	# set +o vi
	
	# set -o ignoreeof
	# set -o noclobber

	<TAB> 
		* 파일이름 자동 완성 기능
		* 디렉토리 안에 파일 목록 보기
		* 명령어 검색하기
	화살표
		* 이전에 수행된 명령어를 편집해서 사용하기
		* 이전에 수행된 명령어를 확장해서 사용하기
		* 확인 + 명령수행 + 확인
	Copy & Paste

변수(Variable)
	변수 종류
	* 지역변수(Local Variable)			# VAR=5
	* 환경변수(Environment Variable)	# export VAR=5
	* 특수변수(Special Variable)		$$, $?, $!, $0, $1, $2, $#, $*
	변수 선언 방법
		# export VAR=5
		# echo $VAR
		# unset VAR
	export 의미
	시스템/쉘 환경변수(set/env)
		PS1 변수: export PS1='[\u@\h \w]\$ ' ($HOME/.bashrc)
		PS2 변수
		PATH 변수: export PATH=$PATH:/root/scripts ($HOME/.bash_profile)
		HISTTIMEFORMAT 변수: export HISTTIMEFORMAT="%F %T  " (/etc/profile)
		HOME 변수
		PWD 변수
		LOGNAME 변수
		USER 변수
		UID 변수
		TERM 변수: export TERM=vt100
		LANG 변수: export LANG=ko_KR.UTF-8

쉘 메타캐릭터(Shell Metacharacter)
	''  ""  ``  \  ; 

명령어 히스토리(Command History)
	HISTSIZE=512
	HISTFILE=$HOME/.bash_history
	HISTFILESIZE=512

엘리어스(Alias)
	# alias cp='cp -i'
	# alias
	# unalias cp

환경파일
* /etc/profile
* ~/.bash_profile
* ~/.bashrc

########################
제 14장 프로세스 관리
########################	

프로세스 정보
	/proc/PID/*
	- PID, PPID

프로세스 관리
	프로세스 관리1
		프로세스 실행
			fg) # gedit 
			bg) # gedit &
		프로세스 확인
			# ps -ef | grep sshd
			# ps aux | grep sshd
		프로세스 종료
			# kill -1|-2|-9|-15 PID PID
			
			[참고] killall CMD, pkill CMD
			[참고] kill vs killall/pkill
	
	프로세스(잡, Job) 관리2
		잡 실행
			fg) # gedit 
			bg)	# gedit &
		잡 확인
			# jobs
			
			# fg %1
			# bg %1
			<CTRL + Z>
		잡 종료
			# kill %1

프로세스 모니터링
	top CMD 
		# top 
		# top -u wasuser
	
		[참고] 모니터링 툴
		* top/htop 	: CPU/MEM
		* iotop 	: DISK I/O
		* iftop 	: Network I/O
		* atop 		: Data Gathering
		* gnome-system-monitor

프로세스 모니터링 관련 명령어
	lsof CMD
		# lsof 
			# lsof /usr/sbin/sshd
			# lsof /tmp
			# lsof /etc/passwd
		# lsof -c sshd
			# lsof /usr/sbin/sshd
			# lsof -c sshd
		# lsof -p PID
		# lsof -i 
	pmap CMD
		# pmap PID
	pstree CMD
		# pstree 
		# pstree user01
		# pstree -alup PID 
	nice/renice CMD
		[실무예] 백업 스크립트/데이터수집 스크립트 실행할 때
		# nice ./backup.sh &
		
		[실무예] CPU 부하가 높은 프로세스가 존재하는 경우
		# renice -n 10 PID

########################
제 15장 원격접속과 파일전송
########################

파일전송
	scp CMD
		# scp file1 server2:/tmp/file2
		# scp server2:/tmp/file2 /test/file1
		# scp -r dir1 server2:/tmp
	sftp CMD
원격접속
	ssh CMD
		# ssh server2
		# ssh server2 CMD
		
		[참고] Public Key Authentication
		# ssh-keygen 
		# ssh-copy-id -i id_rsa.pub root@server2

