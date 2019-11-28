#!/bin/bash

ID=$2

startvm() {
	/usr/sbin/qm start $ID
}

stopvm() {
	/usr/sbin/qm stop $ID
}

shutdownvm() {
	/usr/sbin/qm shutdown $ID
}

case "$1" in
start) startvm ;;
stop) stopvm ;;
shutdown) shutdownvm ;;
restart) stopvm; startvm ;;
*) echo "usage: $0 start|stop|shutdown|restart vm-id" >&2
exit 1
;;
esac