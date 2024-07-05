## Kubespray

```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ''
```

```bash
ssh-copy-id -i ~/.ssh/id_ed25519.pub vagrant@192.168.56.106
```

```bash
sudo apt update
sudo apt install -y python3 python3-pip git
```

```bash
git clone -b release-2.24 https://github.com/kubernetes-sigs/kubespray.git
```

```bash
cd kubespray
sudo pip3 install -r requirements.txt
```

```bash
cp -rfp inventory/sample inventory/mycluster
```

```bash
vi inventory/mycluster/inventory.ini
```

```bash
[all]
kubernetes ansible_host=192.168.56.106 ip=192.168.56.106

[kube_control_plane]
kubernetes

[etcd]
kubernetes

[kube_node]
kubernetes

[calico_rr]

[k8s_cluster:children]
kube_control_plane
kube_node
calico_rr
```

```bash
vi inventory/mycluster/group_vars/k8s_cluster/addons.yml
```

```bash
...
metrics_server_enabled: true
...
ingress_nginx_enabled: true
...
metallb_enabled: true
...
metallb_protocol: "layer2"
...
metallb_config:
  address_pools:
    primary:
      ip_range:
        - 192.168.56.200-192.168.56.209
      auto_assign: true
  ...
  layer2:
    - primary
...
```

```bash
vi inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml
```

```bash
...
kube_proxy_strict_arp: true
```

```bash
ansible all -i inventory/mycluster/inventory.ini -m ping
```

```bash
ansible-playbook -i inventory/mycluster/inventory.ini cluster.yml --become
```

```bash
mkdir ~/.kube
sudo cp /etc/kubernetes/admin.conf ~/.kube/config
sudo chown $USER:$USER ~/.kube/config
```

```bash
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl
exec bash
```

```bash
kubectl get nodes
kubectl cluster-info
```

## NFS Server

```bash
sudo apt install -y nfs-kernel-server
```

```bash
sudo mkdir /srv/volumes
echo "/srv/volumes *(rw,sync,no_subtree_check,no_root_squash)" | sudo tee /etc/exports
```

```bash
sudo exportfs -arv
```

## NFS Provisioner

```bash
cd ~
git clone https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner
```

```bash
cd nfs-subdir-external-provisioner/deploy/
```

```bash
vi deployment.yaml
```

```bash
          env:
            - name: PROVISIONER_NAME
              value: k8s-sigs.io/nfs-subdir-external-provisioner
            - name: NFS_SERVER
              value: 192.168.56.106
            - name: NFS_PATH
              value: /srv/volumes
      volumes:
        - name: nfs-client-root
          nfs:
            server: 192.168.56.106
            path: /srv/volumes
```

```bash
kubectl apply -k .
```

```bash
kubectl patch storageclass nfs-client -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
kubectl get storageclass
```

## Helm

```bash
cd ~
wget https://get.helm.sh/helm-v3.15.2-linux-amd64.tar.gz
```

```bash
tar xf helm-v3.15.2-linux-amd64.tar.gz
```

```bash
sudo install linux-amd64/helm /usr/local/bin/
```

```bash
helm version
```
