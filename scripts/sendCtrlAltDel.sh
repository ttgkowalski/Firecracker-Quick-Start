#!/bin/bash

echo sockets/$1.socket

curl --unix-socket sockets/$1.socket -i \
    -X PUT "http://localhost/actions" \
    -d '{ "action_type": "SendCtrlAltDel" }'