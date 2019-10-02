if [[ $EUID -eq 0 ]]; then
  echo "This script must NOT be run as root" 1>&2
  exit 1
fi

sudo apt install procps ncurses-term -y

spinner()
{
    local pid=$1
    local delay=0.20
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf '\e[1;32m%-6s\e[m' " Done!"
    printf "    \b\b\b\b"
}

install_preliminary() {
  sudo apt-get update
  sudo apt-get install htop psmisc nano vim wget cron software-properties-common apt-transport-https gnupg -y
  sudo echo "deb https://packages.grafana.com/oss/deb stable main" > /etc/apt/sources.list.d/grafana.list
  wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
  sudo apt-get update
}

install_stack() {
  sudo apt-get install npm mosquitto influxdb influxdb-client grafana -y
  sudo npm install -g --unsafe-perm node-red
  npm install -g npm install node-red-contrib-influxdb
}

install_scripts() {
  startstack="mosquitto &
  node-red &
  influxdb &
  grafana &"
  echo "$startstack" > ~/startstack.sh
  chmod +x ~/startstack.sh
  killstack="killall -9 mosquitto node-red influxdb grafana"
  echo "$startstack" > ~/startstack.sh
  chmod +x ~/startstack.sh
}

install_crontab() {
echo "@reboot ~/startstack.sh" > /tmp/userland-mqtt-stack.cron
crontab /tmp/userland-mqtt-stack.cron
}

cleanup() {
    sudo apt-get autoremove -y
}

(printf "Installing requirements to install the stack" && install_preliminary >> ~/mqtt-stack.log) &
spinner $!

(printf "Installing the stack" && install_stack >> ~/mqtt-stack.log) &
spinner $!

(printf "Installing management scripts in ~/" && install_scripts >> ~/mqtt-stack.log) &
spinner $!

(printf "Installing cronjob so services will start on boot" && install_crontab >> ~/mqtt-stack.log ) &
spinner $!

