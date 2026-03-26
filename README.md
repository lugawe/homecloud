# homecloud

My homecloud is based on Debian/Ubuntu.

## Preparation

### Tailscale

Add the tags `k8s` and `homecloud`.

Prepare [OAuth Client](https://login.tailscale.com/admin/settings/trust-credentials), to generate `client_id` and `client_secret`.

### Storage

Install following packages:

```bash
apt install open-iscsi nfs-common
```

Enable iscsid:

```bash
systemctl enable --now iscsid
```
