
#

import re

regexes = [
    "foo.*",
    "bar.*",
    "qu*x"
    ]

# Make a regex that matches if any of our regexes match.
combined = "(" + ")|(".join(regexes) + ")"

if re.match(combined, mystring):
    print "Some regex matched!"


#
strings = ("string1", "string2", "string3")
for line in file:
    if any(s in line for s in strings):
        print "yay!"

awk check if file exists in line


awk '{print $1 $2}' pos_cut.txt
