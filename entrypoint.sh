#!/bin/bash

# Seleccionar las variables de entorno según el entorno (test o prod)
if [ "$ENVIRONMENT" == "test" ]; then
  export PROMETHEUS_URL=$TEST_PROMETHEUS_URL
  export NODE_EXPORTER_TARGETS=$TEST_NODE_EXPORTER_TARGETS
  export LOAD_BALANCER=$TEST_LOAD_BALANCER
  export API_GATEWAY=$TEST_API_GATEWAY
  export NGINX_WEB_CLIENT=$TEST_NGINX_WEB_CLIENT
  export SV_USERS=$TEST_SV_USERS
  export SV_SUPPORT=$TEST_SV_SUPPORT
  export SV_ECOMMERCE=$TEST_SV_ECOMMERCE
  export SV_INVENTORY=$TEST_SV_INVENTORY
elif [ "$ENVIRONMENT" == "prod" ]; then
  export PROMETHEUS_URL=$PROD_PROMETHEUS_URL
  export NODE_EXPORTER_TARGETS=$PROD_NODE_EXPORTER_TARGETS
  export LOAD_BALANCER=$PROD_LOAD_BALANCER
  export API_GATEWAY=$PROD_API_GATEWAY
  export NGINX_WEB_CLIENT=$PROD_NGINX_WEB_CLIENT
  export SV_USERS=$PROD_SV_USERS
  export SV_SUPPORT=$PROD_SV_SUPPORT
  export SV_ECOMMERCE=$PROD_SV_ECOMMERCE
  export SV_INVENTORY=$PROD_SV_INVENTORY
fi

# Generar prometheus.yml a partir de la plantilla
envsubst < /etc/prometheus/prometheus.yml.template > /etc/prometheus/prometheus.yml

# Iniciar Prometheus con la configuración generada
exec /bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/prometheus
