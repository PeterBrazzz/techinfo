#!/usr/bin/env bash

#set -ex

# this function create  logfile 
creating_logfile () {
   echo "$(date)" >> ./usd.log
   echo "1 USD = $string" >> ./usd.log
   echo "------------------------------------" >> ./usd.log
}

#This function will cut out the value of the dollar exchange rate from https://myfin.by/converter/usd-byn
splitting () {
   string=$(curl https://myfin.by/converter/usd-byn | grep -o -P '.{0,1}>1 USD.{15,23}' ) 
   string=$(echo ${string:20})
}

splitting
creating_logfile