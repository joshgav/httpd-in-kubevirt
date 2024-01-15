# httpd-with-kubevirt

Some notes and hints for running httpd in a Kubevirt VM and exposing it via typical Kubernetes networking.

Connect to VM with `virtctl ssh fedora@fedora-1 --identity-file .ssh/id_rsa --namespace ${namespace}`

## Resources
- https://www.redhat.com/en/blog/subscribing-rhel-vms-in-openshift-virtualization
- https://access.redhat.com/documentation/en-us/openshift_container_platform/4.14/html/virtualization/index
- https://kubevirt.io/user-guide/virtual_machines/virtual_machine_instances/
