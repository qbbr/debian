#!/bin/sh

for i in {200..225} ; do nslookup 62.76.96.$i ; done | grep "name =" | sed -e "s@.*name = @@g"
