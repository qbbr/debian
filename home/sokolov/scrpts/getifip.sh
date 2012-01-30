#!/bin/sh
# usage: ./getifip.sh <interface>
/sbin/ifconfig $1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'
