#!/bin/bash

if [ -f ~/.demo-env/overwrite_hosts_and_ports.sh ] ; then
  echo -e "!!! Found ~/.demo-env/overwrite_hosts_and_ports.sh"
  echo -e "!!! will use it to overwrite ports and hosts"
  . ~/.demo-env/overwrite_hosts_and_ports.sh
fi

# Admin API
if [ -z "$ADMIN_PROTOCOL" ];
then
  export ADMIN_PROTOCOL=http
fi
export ADMIN_URL=$ADMIN_PROTOCOL://$ADMIN_HOST:$ADMIN_PORT
export DECK_KONG_ADDR=$ADMIN_URL
export DECK_HEADERS="Kong-Admin-Token:KongRul3z!"
# needed for portal
export KONG_ADMIN_URL=$ADMIN_URL
export KONG_ADMIN_TOKEN=KongRul3z!

# Proxy
if [ -z "$PROXY_PROTOCOL" ];
then
  export PROXY_PROTOCOL=http
fi
export PROXY_URL=$PROXY_PROTOCOL://$PROXY_HOST:$PROXY_PORT
export PROXY_SSL_URL=https://$PROXY_HOST:$PROXY_SSL_PORT

# Manager
if [ -z "$MANAGER_PROTOCOL" ];
then
  export MANAGER_PROTOCOL=http
fi
export MANAGER_URL=$MANAGER_PROTOCOL://$MANAGER_HOST:$MANAGER_PORT

# Portal
if [ -z "$PORTAL_PROTOCOL" ];
then
  export PORTAL_PROTOCOL=http
fi
export PORTAL_URL=$PORTAL_PROTOCOL://$PORTAL_HOST:$PORTAL_PORT

# Portal Admin API
if [ -z "$PORTAL_ADMIN_PROTOCOL" ];
then
  export PORTAL_ADMIN_PROTOCOL=http
fi
export PORTAL_ADMIN_URL=$PORTAL_ADMIN_PROTOCOL://$PORTAL_ADMIN_HOST:$PORTAL_ADMIN_PORT

# UDP
if [ ! -z "$UDP_HOST" ]; then
  export UDP_URL=udp://$UDP_HOST:$UDP_PORT
fi

# gRPC
if [ ! -z "$HTTP2_PROXY_PORT" ]; then
  export GRPC_URL=grpc://$PROXY_HOST:$HTTP2_PROXY_PORT
  export GRPCS_URL=grpcs://$PROXY_HOST:$HTTP2_PROXY_SSL_PORT
fi

echo -e "\n**** Kong configuration settings"
echo -e "Portal-Admin-API: $PORTAL_ADMIN_URL (setting KONG_PORTAL_API_URL)"
echo -e "Kong-Admin-API: $ADMIN_URL (setting KONG_ADMIN_API_URI)"
echo -e "Portal-Host: $PORTAL_HOST:$PORTAL_PORT (setting KONG_PORTAL_GUI_HOST)"

echo -e "**** Kong-Environment"
echo -e "Admin: $ADMIN_URL"
echo -e "Proxy: $PROXY_URL"
echo -e "UDP-Proxy: $UDP_URL"
echo -e "TCP-Proxy: $PROXY_STREAM_TCP_HOST:$PROXY_STREAM_TCP_PORT"
echo -e "Proxy-SSL: $PROXY_SSL_URL"
echo -e "gRPC Proxy: $GRPC_URL"
echo -e "gRPC Proxy-SSL: $GRPCS_URL"
echo -e "Manager: $MANAGER_URL"
echo -e "Portal: $PORTAL_URL"
echo -e "Portal-Admin: $PORTAL_ADMIN_URL"
echo -e ""
echo -e "**** User interfaces URLs"
echo -e "Manager:  $MANAGER_URL"
echo -e "Portal:   $PORTAL_URL"
if [ "$ENABLE_KONG_MESH" = true ]
then
  echo -e "Kong Mesh:  $PROXY_URL/mesh/gui/"
fi

# Kongmap
if [ "$ENABLE_KONGMAP" = true ]
then
  export KONGMAP_URL=http://$ADMIN_HOST:$KONGMAP_PORT
  echo -e "Kongmap:  $KONGMAP_URL" 
fi

# Prometheus / Grafana
if [ "$ENABLE_PROMETHEUS_GRAFANA" = true ]
then
  if [ -z "$GRAFANA_PROTOCOL" ];
  then
    export GRAFANA_PROTOCOL=http
  fi
  export GRAFANA_URL="$GRAFANA_PROTOCOL://$GRAFANA_HOST:$GRAFANA_PORT"
  if [ -z "$PROMETHEUS_PROTOCOL" ];
  then
    export PROMETHEUS_PROTOCOL=http
  fi
  export PROMETHEUS_URL="$PROMETHEUS_PROTOCOL//$PROMETHEUS_HOST:$PROMETHEUS_PORT"
  echo -e "Grafana:    $GRAFANA_URL (admin/admin)"
  echo -e "Prometheus: $PROMETHEUS_URL"
fi

# Syslog
if [ "$ENABLE_SYSLOG" = true ]
then
  if [ -z "$SYSLOG_PROTOCOL" ];
  then
    export SYSLOG_PROTOCOL=http
  fi
  export SYSLOG_URL="$SYSLOG_PROTOCOL://$SYSLOG_HOST:$SYSLOG_PORT"
  echo -e "Syslog:   $SYSLOG_URL (kong/kong)"
fi

# ELK
if [ "$ENABLE_ELK" = true ]
then
  if [ -z "$ELK_PROTOCOL" ];
  then
    export ELK_PROTOCOL=http
  fi
  export KIBANA_URL="$ELK_PROTOCOL://$KIBANA_HOST:$KIBANA_PORT"
  echo -e "Kibana:   $KIBANA_URL" 
fi

# Graylog
if [ "$ENABLE_GRAYLOG" = true ]
then
  if [ -z "$GRAYLOG_PROTOCOL" ];
  then
    export GRAYLOG_PROTOCOL=http
  fi 
  export GRAYLOG_URL="$GRAYLOG_PROTOCOL://$GRAYLOG_HOST:$GRAYLOG_PORT"
  echo -e "Graylog:  $GRAYLOG_URL (admin/admin)" 
fi

# Splunk
if [ "$ENABLE_SPLUNK" = true ]
then
  if [ -z "$SPLUNK_PROTOCOL" ];
  then
    export SPLUNK_PROTOCOL=http
  fi
  export SPLUNK_URL=$SPLUNK_PROTOCOL://$SPLUNK_HOST:$SPLUNK_PORT
  echo -e "Splunk:   $SPLUNK_URL (admin/KongRul3z!)" 
fi

# Zipkin Tracing
if [ "$ENABLE_ZIPKIN" = true ]
then
  if [ -z "$ZIPKIN_PROTOCOL" ];
  then
    export ZIPKIN_PROTOCOL=http
  fi
  export ZIPKIN_URL=$ZIPKIN_PROTOCOL://$ZIPKIN_HOST:$ZIPKIN_PORT
  echo -e "Zipkin Tracing:   $ZIPKIN_URL" 
fi

if [ "$ENABLE_LOCAL_KEYCLOAK" = true ]
then
  if [ -z "$LOCAL_KEYCLOAK_PROTOCOL" ];
  then
    export LOCAL_KEYCLOAK_PROTOCOL=http
  fi
  export KEYCLOAK_URL=$LOCAL_KEYCLOAK_PROTOCOL://$KEYCLOAK_HOST:$KEYCLOAK_PORT
  echo -e "Keycloak: $KEYCLOAK_URL" 
fi

if [ "$ENABLE_OPA" = true ]
then
  if [ -z "$OPA_PROTOCOL" ];
  then
    export OPA_PROTOCOL=http
  fi
  export OPA_URL=$OPA_PROTOCOL://$OPA_HOST:$OPA_PORT
  echo -e "OPA     : $OPA_URL" 
fi

if [ "$ENABLE_UPSTREAM_TLS" = true ] ; 
then
  if [ -z "$UPSTREAM_TLS_GUI_PROTOCOL" ];
  then
    export UPSTREAM_TLS_GUI_PROTOCOL=http
  fi
  export UPSTREAM_TLS_HOST=$ADMIN_HOST
  export UPSTREAM_TLS_GUI_URL=$UPSTREAM_TLS_GUI_PROTOCOL://$UPSTREAM_TLS_HOST:$UPSTREAM_TLS_GUI_PORT
  echo -e "Upstream TLS: $UPSTREAM_TLS_GUI_URL" 
fi
echo -e ""