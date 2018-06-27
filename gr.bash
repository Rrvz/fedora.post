#if grep -qwE "${first}|${last}" .bashrc; then
#  echo "This name already exists"
#else
#  echo "This name doesn't exist yet"
#fi

#work
#grep -E "terfst|name|bashrc " .bashrc && echo $?

grep  "${PATTERN[@]}" .bashrc && echo $?


if [ "${PATTERN[@]}" != "FILE" ]
then
   echo yes
else
   echo no
fi
