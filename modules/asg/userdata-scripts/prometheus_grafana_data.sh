#!/bin/bash
set -x
# Function to install prometheus
install_prometheus () {
sudo apt-get update -y
sudo apt-get upgrade -y
wget https://github.com/prometheus/prometheus/releases/download/v2.46.0/prometheus-2.46.0.linux-amd64.tar.gz
tar -xvzf prometheus-2.46.0.linux-amd64.tar.gz
cd prometheus-2.46.0.linux-amd64
# Move Prometheus Binaries
sudo mkdir -p /etc/prometheus
sudo mv prometheus /usr/local/bin/
sudo mv promtool /usr/local/bin/
sudo mv prometheus.yml /etc/prometheus/
sudo mv consoles /etc/prometheus/
sudo mv console_libraries /etc/prometheus/
# Create Prometheus User and Directory:
sudo useradd --no-create-home --shell /bin/false prometheus
sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus
# Create a Systemd Service for Prometheus
sudo tee /etc/systemd/system/prometheus.service <<EOF
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target
[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/var/lib/prometheus/
[Install]
WantedBy=multi-user.target
EOF
# sudo systemctl daemon-reload
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus
if sudo systemctl daemon-reload; then
    echo "##################################################"
    echo "# prometheus installed successfully."
    echo "##################################################"
else
    echo "##################################################"
    echo "# prometheus not installed."
    echo "##################################################"
fi

}
# Function to install grafana
install_grafana () {
# Add the Grafana Repository
sudo apt-get install -y software-properties-common
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo apt-get update -y
# Function to install grafana
sudo apt-get install grafana -y
# Start and Enable Grafana
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
}

ufw allow 3000
ufw allow 9090

install_prometheus
install_grafana