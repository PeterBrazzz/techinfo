#!/bin/bash

full_path=${@: -1}

file_or_dir_existence () {

if find ${full_path} &>/dev/null ; then 
 return 0
 else 
    echo "[ERROR]: ${full_path} <--------- no such file or dirrectory."
    exit 
fi
}

name_and_path_separating (){
    old_filename=$(basename ${1})          
    old_path=$(dirname ${1})
 
if grep -e '\.' <<< "${old_filename}" &>/dev/null; then         
    file_type=".${old_filename#*.}"
    old_filename="${old_filename%%.*}"
else                                                      
    file_type=''
fi
}

upper () {
    new_filename="$( tr [:lower:] [:upper:] <<< ${old_filename})${file_type}"
    new_path="${old_path}/${new_filename}"
    mv ${full_path} ${new_path} &>/dev/null

    cycle_before_comments "${1}"
}

lower (){
    new_filename="$( tr [:upper:] [:lower:] <<< ${old_filename})${file_type}"
    new_path="${old_path}/${new_filename}"
    mv ${full_path} ${new_path} &>/dev/null 
   
    cycle_before_comments "${1}"
}

first_letter_up (){
    new_filename="$(sed "s/.*/\L&/"<<<${old_filename})"
    new_filename="$( sed -e "s/\b\(.\)/\u\1/g" <<< ${new_filename} )${file_type}"
    new_path="${old_path}/${new_filename}"
    mv ${full_path} ${new_path} &>/dev/null
    
    cycle_before_comments "${1}"
}

cycle_before_comments () {
    if [ $? -eq 0 ]; then 
        ${1}
    else
        echo "[ERROR]: There are no reason to change name. 
from:       "${full_path}"
to:         "${new_path}
    fi
}

add_comments () {
    echo "$full_path -----------------> $new_path" 
}

recursive (){
if [[ -d $full_path ]]; then
    paths_to_recursive_files=($( find ${full_path} | sort -r ))
    for (( i=0; i<${#paths_to_recursive_files[@]}; i++ )); do
        name_and_path_separating "${paths_to_recursive_files[i]}"
        local full_path
         full_path=${paths_to_recursive_files[i]}
        ${1}       
    done
else
    echo "[ERROR]: ${full_path} <--------- is not a dirrectory."
fi
}

file_or_dir_existence
name_and_path_separating "${full_path}"

while [ -n "$1" ]
do
case "$1" in
    -U) upper ;;
    -L) lower ;;
    -M) first_letter_up;;

    -RU) recursive "upper";;
    -RL) recursive "lower";;
    -RM) recursive "first_letter_up";;
    
    -UV) upper "add_comments";;
    -LV) lower "add_comments";;
    -MV) first_letter_up "add_comments";;

    -RUV) recursive "upper "add_comments"";;
    -RLV) recursive "lower "add_comments"";;
    -RMV) recursive "first_letter_up "add_comments"";;

    -*) echo "[ERROR]: unexpected key ${1}";;
esac
shift
done
