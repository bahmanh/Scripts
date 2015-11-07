#!/bin/bash
IMPORT="./data/fileData.csv"
TEMPLATE="./data/template.txt"

dos2unix $IMPORT
#for i in $(cat ${IMPORT})
cat $IMPORT | while read i;
do
#: <<'END'
  VAR_REDID=$(echo $i | awk -F, '{print $1}')
  VAR_ISO=$(echo $i | awk -F, '{print $2}')
  VAR_ACCESS=$(echo $i | awk -F, '{print $3}')
  cat $TEMPLATE | sed -e "s/VAR_REDID/$VAR_REDID/g" \
                      -e "s/VAR_ISO/$VAR_ISO/g" \
                      -e "s/VAR_ACCESS/$VAR_ACCESS/g" \
                >> ./output/output.txt

done 

unix2dos ./output/output.txt


