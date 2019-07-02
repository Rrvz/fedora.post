echo "
AAA
BBB
CCC
tet
" > test-file

cat test-file
# Comment with space ej: # BBB a litle better
sed -e '/BBB/ s/^#*/# /' -i test-file
cat test-file

# Comment without space ej: #BBB
sed -e '/tet/ s/^#*/#/' -i test-file
cat test-file

sudo sed "/$Str_x0/s/^/# /" $F_x0
sed 's/.*000/#&/' file

sed 's/^$Str_x1/# &/' test


# /000/ matches a line with 000
# s perform a substitution on the lines matched above
# The substitution will insert a pound character (#) at the beginning of the line (^)


$ awk '/000/{gsub (/^/,"#")}1' file
#This is a 000 line.
#This is 000 yet ano000ther line.
This is still yet another line

    # gsub function is used to add # infront of the lines which contains 000

$ awk '/000/{gsub (/^/,"#")}1' file

# sed 's/\/a\/b\/c\//\/d\/e\/f\//'    # change "a/b/c/" to "d/e/f/"
sed 's_/a/b/c/_/d/e/f/_'
sed 's;/a/b/c/;/d/e/f/;'
sed 's#/a/b/c/#/d/e/f/#'
sed 's|/a/b/c/|/d/e/f/|'
sed 's /a/b/c/ /d/e/f/ '       # yes, even space
# etc.

