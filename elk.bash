# latest jdk 12c Wed 25 Sep 2019 09:39:30 PM AST
# sudo dnf -y install java-openjdk-devel java-openjdk
sudo dnf -y remove java-openjdk-devel java-openjdk
# need it for logstash and kibana matrix support
sudo dnf -y install java-11-openjdk-devel java-11-openjdk

cat <<EOF | sudo tee /etc/yum.repos.d/elasticsearch.repo
[elasticsearch-7.x]
name=Elasticsearch repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

sudo dnf -y install elasticsearch

JVM_Xms1g="-Xms1g"
JVM_Xmx1g="-Xmx1g"
JVM_Xms4g="-Xms4g"
JVM_Xmx4g="-Xmx4g"
JVM_OPTIONS_FILE="/etc/elasticsearch/jvm.options"

if sudo grep -Eq -- "$JVM_Xms1g|$JVM_Xmx1g" "$JVM_OPTIONS_FILE"
then
    sudo sed -i "/$JVM_Xms1g/c $JVM_Xms4g" $JVM_OPTIONS_FILE
    sudo sed -i "/$JVM_Xmx1g/c $JVM_Xmx4g" $JVM_OPTIONS_FILE
else
    echo ""
fi

sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
#sudo systemctl status elasticsearch.service
#sudo systemctl start elasticsearch.service
sudo systemctl enable --now elasticsearch.service

curl http://localhost:9200

# Create a test index
curl -X PUT "http://127.0.0.1:9200/mytest_index"

# Step 3: Install and Configure Kibana
sudo dnf -y install kibana

# After a successful installation, configure Kibana:
sudo bash -c "cat >> /etc/kibana/kibana.yml" <<-"EOF"
server.host: "0.0.0.0"
server.name: "labit.refidomsa.com.do"
# elasticsearch.url: ["http://localhost:9200"]
EOF


sudo systemctl enable --now kibana
sudo systemctl enable kibana
sudo systemctl status kibana --no-pager

# Firewall rule for Kibana
sudo firewall-cmd --add-port=5601/tcp --permanent
sudo firewall-cmd --reload

# Access to open Kibana Dashboard:

# http://ip-address:5601
# http://170.81.9.17:5601

# Step 4: Install and Configure Logstash
sudo dnf -y install logstash
sudo systemctl enable --now logstash
sudo systemctl enable logstash
sudo systemctl status logstash --no-pager


# Step 5: Install other ELK tools – Bonus
sudo dnf install -y filebeat auditbeat metricbeat packetbeat heartbeat-elastic
