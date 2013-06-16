# coding=utf-8
#!/usr/bin/env python

import urllib
import os

def Download():
    h=open('hosts','w')
    fh=urllib.urlopen("https://smarthosts.googlecode.com/svn/trunk/hosts")
    h.write(fh.read())
    h.close

def Move():
	Download()
	os.system("mv /etc/hosts /etc/hosts.old")
	os.system("mv hosts /etc/hosts")
	print "更新完成，请重启浏览器"
	
def Rwnew():
	os.system("mv etc/hosts.old /etc/hosts")
	print "还原完成，请重启浏览器"

print "请以root权限运行"
print "请选择更新还是还原（1，更新；2，还原）："
i=int(input())

if i==1:
	Move()
else:
	if i==2:
		Renew()
	else:
		print "EOF"
		
