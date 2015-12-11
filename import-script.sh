 #!/bin/bash
IMPORT="./data/fileData.csv"
TEMPLATE="./data/DeleteTemplate.txt"

#********INSTRUCTIONS************#
#Change the path of above two vars to indicate where your template and data (csv) are saved.

#Info for data:
#Column 1: Red ID Numbers
#Column 2: Card Numbers:
#Column 3: Hall Name

#Make sure your csv file is saved in MS DOS csv format from excel.

#Make a new directory named output in the same directory as this script.

#Make sure your template has the following place holders 
#  VAR_REDID for Red ID numbers
#  VAR_ISO for Card numbers
#  VAR_ACCESS for Hall names.


dos2unix $IMPORT

#Purpose of this block of code is to add a newline character to end of csv file
lastline=$(tail -n 1 $IMPORT; echo x); lastline=${lastline%x}
    if [ "${lastline: -1}" != $'\n' ]; then
        echo >> $IMPORT
    fi

echo "Processing files..."
cat $IMPORT | while read i;
do
  VAR_REDID=$(echo $i | awk -F, '{print $1}')
  VAR_ISO=$(echo $i | awk -F, '{print $2}')
  VAR_ACCESS=$(echo $i | awk -F, '{print $3}')
  cat $TEMPLATE | sed -e "s/VAR_REDID/$VAR_REDID/g" \
                      -e "s/VAR_ISO/$VAR_ISO/g" \
                      -e "s/VAR_ACCESS/$VAR_ACCESS/g" \
                >> ./output/output.txt
done 
unix2dos ./output/output.txt
echo "Done"