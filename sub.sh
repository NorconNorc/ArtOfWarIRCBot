#!/bin/bash

read nick chan saying
function has { $(echo "$1" | grep -P "$2" > /dev/null) ; } 

function say { echo "PRIVMSG $1 :$2" ; }

if has "$saying" "^!war\b" ; then
    quote="$(cat suntzuquotes.txt | shuf -n 1)"
    say $chan "$nick: $quote"
fi
if has "$saying" "\bTheArtOfWar: help\b" || has "$saying" "\btheartofwar: help\b" || has "$saying" "\bartofwar: help\b" ; then
    say $chan "Commands: !author- blurb, !war- reads out quotes from the art of war."
fi
if has "$saying" "^!author\b" ; then
    say $chan "$nick: No one knows for sure the origin of Sun-Tzu, as no historical figure exactly matches his description. It is likely a psudonym taken by a master and several desciples, as the art of war was updated periodically several times before becoming the book we now know. Originally The Art of War contained no reference to sieges or castles, as few to none existed where there was fighting at the time."
fi
