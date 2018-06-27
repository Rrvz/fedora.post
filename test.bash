#!/bin/sh
#echo "Enter your sting: "
#read string1
#if grep -qF "$string1" file.txt;then
#   echo "Found it"
#else
#   echo "Sorry this string not in file"
#fi


#PATTERN=('powerline-daemon' 'POWERLINE_BASH_CONTINUATION=1' 'POWERLINE_BASH_SELECT=1' 'bash/powerline.sh')
#FILE=~/.bashrc

Array=('which powerline-daemon' 'POWERLINE_BASH_CONTINUATION=1' 'POWERLINE_BASH_SELECT=1' 'bash/powerline.sh')
FileX=~/.bashrc

#echo ${Array[0]}   # element-zero
                   # First element of array.

#echo ${!Array[@]}  # 0 1 2 3
                   # All the indices of Array.

for index in ${!Array[@]}
do
  echo ${Array[index]} # element-zero

n=0
cat $FileX | while read line; do
    if [[ "$line" = ${Array[index]} && $n = 0 ]]; then
        echo "New Inserted Line"
    n=1
  fi
  echo "$line"
done



#if [ -e /home/tutorialkart/sample.txt ];
#then
#    echo "sample.txt - File exists."
#else
#    echo "sample.txt - File does not exist."
#fi

#for index in $FILE*; do
#   if [[ -e PATTERN=$i ]]; then
#      # exists...
#   fi
#done




#if grep -q $PATTERN $FILE;
# then
#     echo "Here are the Strings with the Pattern '$PATTERN':"
#     echo -e "$(grep $PATTERN $FILE)\n"
# else
#     echo "Error: The Pattern '$PATTERN' was NOT Found in '$FILE'"
#     echo "Exiting..."
#     exit 0
#fi

#if grep -q $PATTERN $FILE;
# then
#     echo "Here are the Strings with the Pattern '${PATTERN[@]}':"
#     echo -e "$(grep ${PATTERN[@]} $FILE)\n"
# else
#     echo "Error: The Pattern '${PATTERN[@]}' was NOT Found in '$FILE'"
#     echo "Exiting..."
#     exit 0
#fi

