#!/usr/bin/env bash

#set -ex

    #This function should find russian letters in code
code () {
    rus=($(echo "$(cat $1)"| grep [А-Яа-я]))
    if [ -z "${rus}" ]; then
      echo "In this file all letters are english"
    else 
      echo "In this file there are some russian letters"
      cut_rus "$@"
    fi
}

    #This function should cut all russian letters from the code
cut_rus () {
    echo "Do you want to cut all russian letters from your file? [y/n]"
    read answr
    if [[ "$answr" == "y" ]]; then 
      cat $1 | tr -d "[А-Яа-я]" > ./new
      cat ./new > $1 
      rm ./new
      echo "all russian letters have been removed from the file"
    else 
      echo "file has not been modified"
    fi
}

code "$@"

