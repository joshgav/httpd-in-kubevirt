apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: ssh-public-key
stringData:
  key1: ${SSH_PUBLIC_KEY}