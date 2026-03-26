# Utilities for using homecloud

apply:
    kustomize build --enable-helm kustomize/overlays/homecloud | kubectl apply --server-side --force-conflicts -f -

nuke namespace:
    kubectl delete all --all -n {{ namespace }}
    kubectl delete pvc --all -n {{ namespace }}
    kubectl delete secret --all -n {{ namespace }}
    kubectl delete configmap --all -n {{ namespace }}
    kubectl delete namespace {{ namespace }}
