sudo yum install radvd -y


# Auto configuration can be disabled temporary for eth1 with:

sudo sysctl -w net.ipv6.conf.eth1.autoconf=0
sudo sysctl -w net.ipv6.conf.eth1.accept_ra=0

# or for all interfaces with:

sudo sysctl -w net.ipv6.conf.all.autoconf=0
sudo sysctl -w net.ipv6.conf.all.accept_ra=0

# activate ipv6 routing
sudo sysctl net.ipv6.conf.all.forwarding
sudo sysctl -n net.ipv6.conf.all.forwarding
sudo sysctl -w net.ipv6.conf.all.forwarding=1

# For hypervisor host config
vim /etc/radvd.conf
# interface wireless
interface wlp2s0
{
AdvSendAdvert on;
MinRtrAdvInterval 30;
MaxRtrAdvInterval 100;
prefix 2001:470:b2d7:dead::/64
{
AdvOnLink on;
AdvAutonomous on;
AdvRouterAddr off;
};

};

sudo systemctl enable radvd.service
sudo systemctl start radvd.service


# For nat VM config
vim /etc/radvd.conf
# interface wireless

interface ens33
{
    AdvSendAdvert on;
    MinRtrAdvInterval 10;
    MaxRtrAdvInterval 15;
    prefix fd15:fed0::/64
    {
        AdvOnLink on;
        AdvAutonomous on;
        AdvRouterAddr off;
    };

    RDNSS fe80::250:56ff:fec0:2222 fd15:fed0::a fd15:fed0::b
    {
        AdvRDNSSLifetime 15;
    }; # End of RDNSS definition

# if DHCPv6 is running Windows doesn’t take the RA RDNSS values.
    DNSSL lab.local
    {
        AdvDNSSLLifetime 60;
    }; # End of DNSSL definition
};


sudo systemctl enable radvd.service
sudo systemctl start radvd.service


radvdump
