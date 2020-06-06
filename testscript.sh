#!/bin/bash

ls -id ~/C
#1704319 /root/C

debugfs -R "ncheck 1704319" /dev/sda2

#Inode	Pathname
#1704319	/root/C
