Name:           pingfederate-9f558b4b
Namespace:      ping-cloud-kyryloyermak
Selector:       app=ping-cloud,pod-template-hash=9f558b4b,role=pingfederate-engine
Labels:         app=ping-cloud
                cluster=pingfederate-cluster
                pod-template-hash=9f558b4b
                role=pingfederate-engine
Annotations:    deployment.kubernetes.io/desired-replicas: 2
                deployment.kubernetes.io/max-replicas: 3
                deployment.kubernetes.io/revision: 1
Controlled By:  Deployment/pingfederate
Replicas:       2 current / 2 desired
Pods Status:    2 Running / 0 Waiting / 0 Succeeded / 0 Failed
Pod Template:
  Labels:           app=ping-cloud
                    cluster=pingfederate-cluster
                    pod-template-hash=9f558b4b
                    role=pingfederate-engine
  Annotations:      lastUpdateReason: NA
  Service Account:  ping-serviceaccount
  Init Containers:
   pingfederate-init:
    Image:      curlimages/curl:7.68.0
    Port:       <none>
    Host Port:  <none>
    Command:
      /init.sh
    Environment Variables from:
      pingfederate-environment-variables  ConfigMap  Optional: false
    Environment:                          <none>
    Mounts:
      /.ssh from ssh-dir (rw)
      /data from data-dir (rw)
      /id_rsa from ssh-id-key-secret (rw,path="id_rsa")
      /init.sh from pingfederate-init (rw,path="init.sh")
      /known_hosts from known-hosts-config (rw,path="known_hosts")
  Containers:
   pingfederate:
    Image:      pingidentity/pingfederate:10.0.1-edge
    Port:       9031/TCP
    Host Port:  0/TCP
    Limits:
      cpu:     1
      memory:  2Gi
    Requests:
      cpu:      1
      memory:   2Gi
    Liveness:   exec [liveness.sh] delay=0s timeout=1s period=30s #success=1 #failure=10
    Readiness:  exec [liveness.sh] delay=0s timeout=1s period=30s #success=1 #failure=10
    Environment Variables from:
      pingfederate-environment-variables  ConfigMap  Optional: false
      devops-secret                       Secret     Optional: true
    Environment:
      WAIT_FOR_SERVICES:      pingfederate-admin
      OPERATIONAL_MODE:       CLUSTERED_ENGINE
      PF_DNS_PING_NAMESPACE:   (v1:metadata.namespace)
      PF_LDAP_PASSWORD:       <set to the key 'PF_LDAP_PASSWORD' in secret 'pingcommon-passwords'>  Optional: false
    Mounts:
      /opt/in/instance/server/default/conf/pingfederate.lic from pingfederate-license (rw,path="pingfederate.lic")
      /opt/in/instance/server/default/data/pf.jwk from pingfederate-jwk (rw,path="pf.jwk")
      /root/.ssh from ssh-dir (rw)
      /usr/local/bin/kubectl from data-dir (rw,path="kubectl")
  Volumes:
   ssh-dir:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
   data-dir:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
   pingfederate-init:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      pingfederate-init
    Optional:  false
   ssh-id-key-secret:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  ssh-id-key-secret
    Optional:    true
   known-hosts-config:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      known-hosts-config
    Optional:  true
   pingfederate-license:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  pingfederate-license
    Optional:    true
   pingfederate-jwk:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  pingfederate-jwk
    Optional:    true
Events:
  Type    Reason            Age   From                   Message
  ----    ------            ----  ----                   -------
  Normal  SuccessfulCreate  50m   replicaset-controller  Created pod: pingfederate-9f558b4b-548nw
