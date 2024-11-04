#!/bin/bash

# Cargar variables de entorno
source .env

# Definir el archivo de configuración según el ambiente
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
else
    echo "Error: ENVIRONMENT no está configurado correctamente (debe ser 'test' o 'prod')"
    exit 1
fi

# Generar el archivo prometheus.yml a partir de prometheus.yml.template
envsubst < /etc/prometheus/prometheus.yml.template > /etc/prometheus/prometheus.yml

# Ejecutar Prometheus
exec prometheus --config.file=/etc/prometheus/prometheus.yml
