#! /usr/bin/env bash

this_dir=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
root_dir=$(cd ${this_dir}/.. && pwd)
if [[ -e "${root_dir}/.env" ]]; then source ${root_dir}/.env; fi
if [[ -e "${this_dir}/.env" ]]; then source ${this_dir}/.env; fi
source ${this_dir}/lib/kubernetes.sh

argocd_namespace=openshift-gitops
app_namespace=httpd-kubevirt
ensure_namespace ${app_namespace}

${this_dir}/create-config.sh ${app_namespace}

ssh_key_path=${root_dir}/.ssh
if [[ ! -e "${ssh_key_path}/id_rsa" ]]; then
    ssh-keygen -t rsa -b 4096 -C "user@openshift" -f "${ssh_key_path}/id_rsa" -N ''
fi
export SSH_PUBLIC_KEY=$(cat ${ssh_key_path}/id_rsa.pub)

kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: ssh-public-key
stringData:
  key1: ${SSH_PUBLIC_KEY}
EOF

kubectl apply -n ${argocd_namespace} -f ${this_dir}/argocd-application.yaml
