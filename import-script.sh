#!/bin/bash
IMPORT="./data/file.csv"
TEMPLATE="./data/temp.txt"

for i in `cat ${IMPORT}`
do 
  VAR_COL1=`echo $i | awk -F, '{print $1}'`
  VAR_COL2=`echo $i | awk -F, '{print $2}'`
  VAR_COL3=`echo $i | awk -F, '{print $3}'`
  cat $TEMPLATE | sed -e s/VAR_COL1/$VAR_COL1/g \
                      -e s/VAR_COL2/$VAR_COL2/g \
                      -e s/VAR_COL3/$VAR_COL3/g \
                >> ./output/output-temp.txt
done