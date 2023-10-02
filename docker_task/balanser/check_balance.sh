#! /bin/bash
for ((i=0; i<1000; i++))
do 
 curl http://localhost/ >> file
done 

site1=$(grep "1" file | wc -l)
site2=$(grep "2" file | wc -l)
echo "site1: " $site1
echo "site2: " $site2
rm file