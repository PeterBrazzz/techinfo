#!/usr/bin/env bash

#set -x

make_arr() {
    local num_colmn
    num_colmn="${1}"
    sort /etc/passwd | awk -F: "{ print \$${num_colmn} }"
}

login=($(make_arr "1")) 
uid=($(make_arr "3")) 
gid=($(make_arr "4"))

for (( i=0; i<${#login[@]}; i++ )); do

   groups=($(grep -E "[:,](${login[i]})" /etc/group | grep -w "${login[i]}" | awk -F: '{ print$1 }'))
  
   groups+=($(grep -w "${gid[i]}" /etc/group | awk -F: '{ print$1 }'))
   uniqs_arr=($(for gr in "${groups[@]}"; do echo "${gr}"; done | sort -u))
    echo "Login: ${login[i]} 
    UID: ${uid[i]}
    GID: ${gid[i]}
    Group(s): ${uniqs_arr[@]} 
    -------------------------" 
done