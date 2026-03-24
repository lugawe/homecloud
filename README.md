# homecloud

My homecloud is based on Debian/Ubuntu.

## Preparation

### Storage

Install following packages:

```bash
apt install open-iscsi nfs-common
```

Enable iscsid:

```bash
systemctl enable --now iscsid
```
