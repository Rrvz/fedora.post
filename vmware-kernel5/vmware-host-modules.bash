rm -rf vmware-host-modules
git clone https://github.com/mkubecek/vmware-host-modules.git
cd vmware-host-modules
# git checkout -b w15.1.0-k5.1
git checkout workstation-15.1.0
make
sudo make install
sudo /etc/init.d/vmware restart
echo "Kernel update for VMware has been installed"
echo "Deleting vmware-host directory"
cd ..; rm -rf vmware-host-modules
echo "Directory deteled"; echo ""
echo "Directory deteled"; echo "Hasta la vista baby!!!"
