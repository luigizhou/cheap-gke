apiVersion: apps/v1
kind: Deployment
metadata:
  name: kubeip
  namespace: kube-system
spec:
  replicas: 1
  selector:
    matchLabels:
      app: kubeip
  template:
      metadata:
        labels:
          app: kubeip
      spec:
        priorityClassName: system-cluster-critical
        nodeSelector:
          cloud.google.com/gke-nodepool: ${node-pool}
        containers:
        - name: "kubeip"
          image: doitintl/kubeip:latest
          imagePullPolicy: Always
          volumeMounts:
          - name: google-cloud-key
            mountPath: /var/secrets/google
          env:
          - name: "KUBEIP_LABELKEY"
            valueFrom:
              configMapKeyRef:
                key: "KUBEIP_LABELKEY"
                name: "kubeip-config"
          - name: "KUBEIP_LABELVALUE"
            valueFrom:
              configMapKeyRef:
                key: "KUBEIP_LABELVALUE"
                name: "kubeip-config"
          - name: "KUBEIP_NODEPOOL"
            valueFrom:
              configMapKeyRef:
                key: "KUBEIP_NODEPOOL"
                name: "kubeip-config"
          - name: "KUBEIP_FORCEASSIGNMENT"
            valueFrom:
              configMapKeyRef:
                key: "KUBEIP_FORCEASSIGNMENT"
                name: "kubeip-config"
          - name: "KUBEIP_ORDERBYLABELKEY"
            valueFrom:
              configMapKeyRef:
                key: "KUBEIP_ORDERBYLABELKEY"
                name: "kubeip-config"
          - name: "KUBEIP_ORDERBYDESC"
            valueFrom:
              configMapKeyRef:
                key: "KUBEIP_ORDERBYDESC"
                name: "kubeip-config"
          - name: "KUBEIP_ADDITIONALNODEPOOLS"
            valueFrom:
              configMapKeyRef:
                key: "KUBEIP_ADDITIONALNODEPOOLS"
                name: "kubeip-config"
          - name: "KUBEIP_COPYLABELS"
            valueFrom:
              configMapKeyRef:
                key: "KUBEIP_COPYLABELS"
                name: "kubeip-config"
          - name: "KUBEIP_CLEARLABELS"
            valueFrom:
              configMapKeyRef:
                key: "KUBEIP_CLEARLABELS"
                name: "kubeip-config"
          - name: "KUBEIP_DRYRUN"
            valueFrom:
              configMapKeyRef:
                key: "KUBEIP_DRYRUN"
                name: "kubeip-config"
          - name: "KUBEIP_TICKER"
            valueFrom:
              configMapKeyRef:
                key: "KUBEIP_TICKER"
                name: "kubeip-config"
          - name: "KUBEIP_ALLNODEPOOLS"
            valueFrom:
              configMapKeyRef:
                key: "KUBEIP_ALLNODEPOOLS"
                name: "kubeip-config"
          - name: GOOGLE_APPLICATION_CREDENTIALS
            value: /var/secrets/google/key.json
        restartPolicy: Always
        serviceAccountName: kubeip-sa
        volumes:
          - name: google-cloud-key
            secret:
              secretName: kubeip-key