#! /bin/bash

#set -ex

# This script parses the site and logs the current dollar rate.

# this function create  logfile
creating_logfile () {
   echo "$(date)
   1 USD = $string
   ------------------------------------" >> /var/log/usd.log
}

#This function will cut out the value of the dollar exchange rate from https://myfin.by/converter/usd-byn
splitting () {
   string=$(curl https://myfin.by/converter/usd-byn | grep -o -P '.{0,1}>1 USD.{15,23}' )
   string=$(echo ${string:20})
}

splitting
creating_logfile
