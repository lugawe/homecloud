# Utilities for using homecloud

apply:
    kustomize build --enable-helm kustomize/overlays/homecloud | kubectl apply --server-side --force-conflicts -f -

