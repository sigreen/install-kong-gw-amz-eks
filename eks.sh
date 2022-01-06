#!/bin/bash
all_services=$(kubectl get services -n kong-enterprise -o json | jq -r '[.items[] | {ingress:.status.loadBalancer.ingress,name:.metadata.name}]')

export PROXY_HOST=$(echo $all_services | jq -r '.[] | select(.name|test("proxy")) | .ingress[0].hostname')
export PROXY_PORT=80

export ADMIN_HOST=$(echo $all_services | jq -r '.[] | select(.name|test("admin")) | .ingress[0].hostname')
export ADMIN_PORT=8001

export MANAGER_HOST=$(echo $all_services | jq -r '.[] | select(.name|test("manager")) | .ingress[0].hostname')
export MANAGER_PORT=8002

export PORTAL_HOST=$(echo $all_services | jq -r '.[] | select(.name|test("portal$")) | .ingress[0].hostname')
export PORTAL_PORT=8003

export PORTAL_ADMIN_HOST=$(echo $all_services | jq -r '.[] | select(.name|test("portalapi")) | .ingress[0].hostname')
export PORTAL_ADMIN_PORT=8004

export COMMON_DOMAIN=$(echo $PORTAL_ADMIN_HOST | sed '/\..*\./s/^[^.]*\.//')
export COMMON_DOMAIN=".$COMMON_DOMAIN"

echo -e "Common DNS: $COMMON_DOMAIN"