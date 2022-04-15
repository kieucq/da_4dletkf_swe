#!/bin/sh
time1=0
id=0
ih=0
im=0
ih=$(($time1/60))
im=`expr $time1 % 60`
if [ "$ih" -ge "24" ]; then
 id=$(($ih/24))
 ih=`expr $ih % 24`
fi
echo "im = $im"
echo "ih = $ih"
echo "id = $id"
 if [ "$im" -lt 10 ]; then
  mm="0$im"
 elif [ "$im" -lt 60 ]; then
  mm="$im"
 else
  echo " minute index calculation is incorrect ...exit 1"
  exit 1
 fi
 if [ "$ih" -lt 10 ]; then
  hh="0$ih"
 elif [ "$ih" -lt 24 ]; then
  hh="$ih"
 else
  echo " hour index calculation is incorrect ...exit 1"
  exit 1
 fi
 if [ "$id" -lt 10 ]; then
  dd="0$id"
 elif [ "$id" -lt 100 ]; then
  dd="$id"
 else
  echo " day index calculation is out of range 100 days ...exit 2"
  exit 2
 fi
 get_file="$dd:$hh:$mm"
 echo $get_file
