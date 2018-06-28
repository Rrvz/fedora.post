
File_X0="/etc/dnf/dnf.conf"
String_X0="strict="
if [ ! -z $(grep "$String_X0" "$File_X0") ]; then 
    String_X0="strict=False"
    if [ ! -z $(grep "$String_X0" "$File_X0") ]; then
        echo "$String_X0 is already in file"
    else
        String_X0="strict=True"
        sudo sed  "/stric=True/stric=False" /etc/dnf/dnf.conf
    fi

else echo "Not Found"
fi


sudo sed "/strict=/c\strict=True" /etc/dnf/dnf.conf

