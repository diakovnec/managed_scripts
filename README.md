# Restart default dns pods in openshift-dns namespace

## Desctiption 
This cript will trigger a rollout of deamonset controlling dns default pods

## Usage

While testing use 
ocm backplane testjob create restart_dns_pods -p NAMESPACE=openshift-dns

```bash
ocm backplane managedjob create CEE/restart-dns-pods
```



