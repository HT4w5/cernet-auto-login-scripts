#!/bin/sh
## Auto login script for CERNET on alpine.
# This file should be in /etc.

# Your ID and Password.
NET_ID=
NET_PASSWD=
RETRY=3
LOGIN_UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36"


attempt_login() {
    # Login.
    echo "Logging in..."
    result=$(curl 'http://10.6.8.2:903/include/auth_action.php' -H 'Accept: */*' -H 'Accept-Language: zh-CN,zh;q=0.9' -H 'Connection: keep-alive' -H 'Content-Type: application/x-www-form-urlencoded' -H 'DNT: 1' -H 'Origin: http://10.6.8.2:903' -H 'Referer: http://10.6.8.2:903/srun_portal_pc.php?ac_id=1&' -H "User-Agent: ${LOGIN_UA}" -H 'X-Requested-With: XMLHttpRequest'   --data-raw "action=login&username=${NET_ID}&password=${NET_PASSWD}&ac_id=1&user_ip=&nas_ip=&user_mac=&save_me=1&ajax=1" --insecure)

    if [ -z "$(echo $result|grep login_ok)" ]
    then
        echo "Login failure!"
        return 1
    else
        echo "Login success!"
        #return 0
        exit 0
    fi
}


# Retry several times on failure.
n=1
while [ $n -le $RETRY ]
do
    echo "Trial $n"
    attempt_login
    let n+=1
done

echo "CERNET login failed, please update your configuration."
exit 1