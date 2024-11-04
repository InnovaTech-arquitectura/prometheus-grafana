FROM bitnami/prometheus:latest

# Copiar el script y el archivo de configuración
COPY entrypoint.sh /entrypoint.sh
COPY prometheus/prometheus.yml.template /etc/prometheus/prometheus.yml.template

# Definir el punto de entrada
ENTRYPOINT ["/entrypoint.sh"]
