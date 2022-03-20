apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: kubeip-key
  namespace: kube-system
data:
  key.json: ${kubeip-serviceaccount}

