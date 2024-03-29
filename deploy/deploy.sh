#! /usr/bin/env bash

this_dir=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
root_dir=$(cd ${this_dir}/.. && pwd)
if [[ -e "${root_dir}/.env" ]]; then source ${root_dir}/.env; fi
if [[ -e "${this_dir}/.env" ]]; then source ${this_dir}/.env; fi
source ${this_dir}/lib/kubernetes.sh

export namespace=httpd-kubevirt
ensure_namespace ${namespace} true

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

apply_kustomize_dir ${root_dir}/resources

# virtctl ssh fedora@fedora-1 --identity-file .ssh/id_rsa --namespace ${namespace}
