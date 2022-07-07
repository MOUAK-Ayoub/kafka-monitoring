mkdir prometheus
wget https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.17.0/jmx_prometheus_javaagent-0.17.0.jar
wget https://raw.githubusercontent.com/prometheus/jmx_exporter/master/example_configs/kafka-2_0_0.yml

sudo systemctl daemon-reload
sudo systemctl restart kafka



wget https://github.com/prometheus/prometheus/releases/download/v2.36.2/prometheus-2.36.2.linux-amd64.tar.gz
tar -xzf prometheus-2.36.2.linux-amd64.tar.gz
mv prometheus-2.36.2.linux-amd64 prometheus-2.3.2
rm prometheus-2.36.2.linux-amd64.tar.gz
copy prometheus.yaml
cd $HOME/prometheus/prometheus-2.36.2
./prometheus
