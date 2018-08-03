#! /bin/sh

cd snmp_exporter
# rebuild snmp definitions from placed resources
cat snmp_*.yml > snmp.yml

./snmp_exporter

