#!/bin/bash
read key
function send {
    echo "-> $1"
    echo "$1" >> .botfile
}


rm .botfile
mkfifo .botfile
tail -f .botfile | ncat -C --ssl <server> 6697 | while true ; do
    if [[ -z $started ]] ; then
        send "NICK TheArtOfWar" 
        send "USER me me me ; still me" 
        send "JOIN <channel> $key"
        started="yes"
    fi
    read irc
    echo "<- $irc"
    if `echo $irc | cut -d ' ' -f 1 | grep PING > /dev/null` ; then
        send "PONG"
    elif `echo $irc | grep PRIVMSG > /dev/null` ; then
        chan=$(echo $irc | cut -d ' ' -f 3)
        barf=$(echo $irc | cut -d ' ' -f 1-3)
        saying=$(echo ${irc##$barf :} | tr -d "\r\n")
        nick="${irc%%!*}"; nick="${nick#:}"
        var=$(echo "$nick" "$chan" "$saying" | ./commands.sh)
        if [[ ! -z $var ]] ; then
            send "$var"
        fi
    fi
done
