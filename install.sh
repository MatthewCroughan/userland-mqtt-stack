sudo apt-get update
sudo apt-get install htop psmisc nano vim wget cron software-properties-common apt-transport-https gnupg -y

sudo echo "deb https://packages.grafana.com/oss/deb stable main" > /etc/apt/sources.list.d/grafana.list
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo apt-get update
sudo apt-get install npm mosquitto influxdb influxdb-client grafana -y

sudo apt-get autoremove -y

sudo npm install -g --unsafe-perm node-red
npm install -g npm install node-red-contrib-influxdb

startstack="mosquitto &
node-red &
influxdb &
grafana &"
echo "$startstack" > ~/startstack.sh
chmod +x ~/startstack.sh

killstack="killall -9 mosquitto node-red influxdb grafana"
echo "$startstack" > ~/startstack.sh
chmod +x ~/startstack.sh

echo "@reboot ~/startstack.sh" > /tmp/userland-mqtt-stack.cron
crontab /tmp/userland-mqtt-stack.cron
