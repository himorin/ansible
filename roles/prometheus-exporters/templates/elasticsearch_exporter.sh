#! /bin/sh

./elasticsearch_exporter \
    --es.uri=http://{{ site_config.prometheus_exporter.es.host }}:9200 \
    --es.all=true \
    --es.indices=true 

