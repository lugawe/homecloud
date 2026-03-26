# homecloud

My homecloud is based on Debian/Ubuntu.

## Preparation

### Storage

Ensure the following mount directories exist:

```
/mnt/homecloud/k3s
/mnt/homecloud/longhorn
```

Install following packages:

```bash
apt install open-iscsi nfs-common
```

Enable iscsid:

```bash
systemctl enable --now iscsid
```


### Install k3s

Installation:

```bash
# Prepare config
mkdir -p /etc/rancher/k3s && echo "data-dir: /mnt/homecloud/k3s" > /etc/rancher/k3s/config.yaml

# Install k3s
curl -sfL https://get.k3s.io | sh -
```

### Tailscale

Add the tags `k8s` and `homecloud`.

Prepare [OAuth Client](https://login.tailscale.com/admin/settings/trust-credentials), to generate `client_id` and `client_secret`.
