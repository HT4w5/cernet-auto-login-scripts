#!/bin/sh
## Auto login script for CERNET on alpine.
# This file should be in /etc.
# Add this file to crontab.

TEST_URL="http://baidu.com"
TEST_UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36"

touch /tmp/cernet-chk-started
# Check whether logged in
wget_result="$(wget --timeout=3 -qO- $TEST_URL --user-agent="$TEST_UA")"

while true
do
    if [ -z "$(echo $wget_result|grep http://10)" ] # need to improve this
    then
        echo "CERNET online."
        exit 0
    elif [ -z "$(echo $wget_result|grep baidu)" ]
    then
        echo "CERNET offline."
        source /etc/cernet-reconn.sh
    fi
done