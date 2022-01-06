#!/bin/bash
echo -e "This script will install a fresh Kubernetes cluster in AWS (EKS)"
echo -e "Keep in mind that this service is cost intensive so delete it as soon as you do not need it anymore more with the also included delete.sh script"
echo -e "*** Prerequesites"
echo -e "*** 1. An AWS account (obviously)"
echo -e "*** 2. aws cli installed on your machine"
echo -e "*** 3. aws cli configured with a user having enough permissions"
echo -e "*** 4. eksctl installed (https://eksctl.io/)"
echo -e "*** 5. kubectl"
echo -e "*** 6. Helm (version 3, not version 2!)"
echo -e "*** 7. yq"
echo -e "*** 8. jq"
echo -e "*** If you want a different region than the default one edit the cluster.yaml file"
echo -e "******************************************"
echo
echo -e "If you are ready go press ENTER, otherwise stop now using ctrl-c"
read
#. ./create_k8s_cluster.sh
. ./create_secrets.sh

cp values.yaml.template values.yaml

echo -e "\n*** Installing Kong Enterprise"
helm install kong-enterprise kong/kong  --set ingressController.installCRDs=false -f ./values.yaml -n kong-enterprise --version 1.14.3

echo -e "\n ☕ Installation done - load balancers on AWS will need a while so we'll wait now for two minutes as we need their dns entries"
sleep 120
. ./patch_addresses.sh

echo -e "\n*** Loadbalancer have been created and external dns is known - we are upgrading the Helm setup now to the created addresses"

helm upgrade kong-enterprise kong/kong --set ingressController.installCRDs=false -f ./values.yaml -n kong-enterprise --version 1.14.3

. ./eks.sh
. ./shared.sh

rm values.yaml