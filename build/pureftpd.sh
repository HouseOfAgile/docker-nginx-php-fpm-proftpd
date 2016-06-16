#!/bin/sh

/usr/sbin/pure-ftpd -P 10.10.10.10 -p 30000:30009 -c 30 -C 8 -l puredb:/etc/pure-ftpd/pureftpd.pdb -O CLF:/var/log/pure-ftpd/transfer.log -x -E -j -R

