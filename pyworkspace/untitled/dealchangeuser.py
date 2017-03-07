#!/usr/bin/env python
# coding:utf8

import random
import MySQLdb
import re

db_host = "172.22.14.190"
db_user = "icpuser"
db_passwd = "123456"
db_database = "icp"

conn=MySQLdb.connect(host=db_host,user=db_user,passwd=db_passwd,db=db_database,charset='utf8')
cur = conn.cursor()

sql = "select email from uud_userbscinfo ORDER BY utime DESC"

file = open("secret.txt")

cur.execute(sql)
rows = cur.fetchall()
for row in rows:
	line = file.readline()
	if not line:
		break
	linesp = line.split(',')
	newuserid = linesp[0]
	newuname = linesp[1].strip()
	olduserid = row[0]
	print newuserid,newpasswd,olduserid
	sql = "update uud_userbscinfo set email='%s',uname='%s' where email='%s'"% (newuserid,newuname,olduserid)
	cur.execute(sql)
	# sql = "update obs_user set userid='%s' where userid = '%s';"%(newuserid,olduserid)
	cur.execute(sql)
	print sql

conn.commit()
cur.close()
conn.close()
