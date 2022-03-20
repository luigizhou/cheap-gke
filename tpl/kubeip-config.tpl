apiVersion: v1
data:
  KUBEIP_LABELKEY: "kubeip"
  KUBEIP_LABELVALUE: "${cluster-name}"
  KUBEIP_NODEPOOL: "${node-pool}"
  KUBEIP_FORCEASSIGNMENT: "true"
  KUBEIP_ADDITIONALNODEPOOLS: ""
  KUBEIP_TICKER: "5"
  KUBEIP_ALLNODEPOOLS: "false"
  KUBEIP_ORDERBYLABELKEY: "priority"
  KUBEIP_ORDERBYDESC: "true"
  KUBEIP_COPYLABELS: "false"
  KUBEIP_CLEARLABELS: "false"
  KUBEIP_DRYRUN: "false"
kind: ConfigMap
metadata:
  labels:
    app: kubeip
  name: kubeip-config
  namespace: kube-system
