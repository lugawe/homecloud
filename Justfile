# Utilities for using homecloud

apply: apply-namespaces-and-crds apply-all

apply-namespaces-and-crds:
    kustomize build --enable-helm kustomize/overlays/homecloud | \
        yq 'select(.kind == "Namespace" or .kind == "CustomResourceDefinition")' | \
        kubectl apply --server-side --force-conflicts -f -
    kubectl wait --for=condition=established crd --all --timeout=60s

apply-all:
    kustomize build --enable-helm kustomize/overlays/homecloud | kubectl apply --server-side --force-conflicts -f -

test:
    kustomize build --enable-helm kustomize/overlays/homecloud | kubectl apply --server-side --dry-run=server -f -

sync:
    kubectl annotate applications -n argocd --all argocd.argoproj.io/refresh=hard --overwrite

nuke namespace:
    kubectl delete all --all -n {{ namespace }}
    kubectl delete pvc --all -n {{ namespace }}
    kubectl delete secret --all -n {{ namespace }}
    kubectl delete configmap --all -n {{ namespace }}
    kubectl delete namespace {{ namespace }}

download-backup:
    ./scripts/download-backup.sh

upload-backup:
    ./scripts/upload-backup.sh
