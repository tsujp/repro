#!/bin/bash

# this is only applicable if you're using the Kitty terminal, or any other
# terminal where after connecting to the machine you have erroneous stdin
# (in which case we can flesh that out then)

# e.g. when you type backspace it actually prints to the right visible
#      whitespace. if unsure ask someone, otherwise you stand to gain nothing
#      by using this

# usage:
#      ./terminfo-ssh.bash BOX_NAME

if [ "$#" -ne 1 ]; then
  printf "Only call this with exactly one argument; the vagrant box's name.\nFor a list of boxes available to you run:\n\n\tvagrant status\n"
  exit 1
fi

if ! command -v vagrant &> /dev/null; then
  printf "You don't have vagrant.\n"
  exit 1
fi

if sshcfg=$(vagrant ssh-config "$1"); then
  echo "$sshcfg" > /tmp/conf && kitty +kitten ssh -F /tmp/conf "$1"
  exit 1
else
  # vagrant prints the error
  exit 1
fi
