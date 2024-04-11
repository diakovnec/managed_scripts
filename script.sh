#!/bin/bash

set -e
set -o errexit
set -o nounset
set -o pipefail

CURRENTDATE=$(date +"%Y-%m-%d %T")

## validate input
if [[ -z "${NAMESPACE}" ]]; then
    echo "Variable NAMESPACE cannot be blank"
    exit 1
fi

start_job(){
    echo "Job started at $CURRENTDATE"
    echo ".................................."
    echo
}

finish_job(){
    echo
    echo ".................................."
    echo "Job finished at $CURRENTDATE"
}



## Function for kubelet restart
restart_dns_pods(){

    echo "Restarting dns_pods in \"${NAMESPACE}\"..."
    
    oc -n openshift-dns rollout restart ds/dns-default

    if [ $? -eq 0 ]; then 
        echo "[SUCCESS] Pods rollout started in \"${NAMESPACE}\" ."
        echo
    else
        echo "[Error] Pods rollout has failed."
        exit 1
    fi

}


## Function for kubelet restart
monitor_dns_pods_restar_progress(){

    echo "Restarting dns_pods in \"${NAMESPACE}\"..."

    oc -n openshift-dns rollout status ds/dns-default 

    if [ $? -eq 0 ]; then
        echo "[SUCCESS] Pods rollout is completed successfully \"${NAMESPACE}\" ."
        echo
    else
        echo "[Error] Pods rollout has failed."
        exit 1
    fi

}




main(){
    start_job
    restart_dns_pods
    monitor_dns_pods_restar_progress
    finish_job
}

main
