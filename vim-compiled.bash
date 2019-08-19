sudo yum install gcc-c++ ncurses-devel python-devel

git clone https://github.com/vim/vim.git
cd vim/src
sudo make distclean
./configure --enable-gui=auto --enable-gtk2-check --with-x --prefix=/usr
sudo make
sudo make install



or installed from repo

wget http://mirror.ghettoforge.org/distributions/gf/gf-release-latest.gf.el7.noarch.rpm
yum install gf-release-latest.gf.el7.noarch.rpm

wget -4 http://mirror.ghettoforge.org/distributions/gf/RPM-GPG-KEY-gf.el7
rpm --import RPM-GPG-KEY-gf.el7

rpm -Uvh http://mirror.ghettoforge.org/distributions/gf/gf-release-latest.gf.el7.noarch.rpm
rpm --import http://mirror.ghettoforge.org/distributions/gf/RPM-GPG-KEY-gf.el7
yum -y remove vim-minimal vim-common vim-enhanced sudo
yum -y --enablerepo=gf-plus install vim-X11 vim-enhanced sudo
