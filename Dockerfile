FROM prom/prometheus:latest

# Instalar envsubst (parte de gettext)
RUN apk add --no-cache gettext

# Copiar el script y el archivo de configuración
COPY entrypoint.sh /entrypoint.sh
COPY prometheus/prometheus.yml.template /etc/prometheus/prometheus.yml.template

# Hacer el script ejecutable
RUN chmod +x /entrypoint.sh

# Definir el punto de entrada
ENTRYPOINT ["/entrypoint.sh"]
