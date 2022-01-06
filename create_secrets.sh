#!/bin/bash

echo -e "\n*** Creating namespace"
kubectl create namespace kong-enterprise


echo -e "\n*** Creating secret for sessions"
kubectl create secret generic kong-session-config -n kong-enterprise --from-file=admin_gui_session_conf --from-file=portal_session_conf

echo -e "\n*** Creating secret for license"
kubectl create secret generic kong-enterprise-license -n kong-enterprise --from-file=./license