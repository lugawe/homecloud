#!/usr/bin/env bash

# HashiCorp Vault - init and configure

set -euo pipefail

if [ "$(basename "$PWD")" != "homecloud" ]; then
	echo "Error: must be run from the homecloud directory"
	exit 1
fi

SECRETS_DIR="secrets/.env.secrets"
VAULT_INIT_FILE="$SECRETS_DIR/vault-init"

v() {
	kubectl exec -n secrets-system svc/vault -- "$@"
}

init() {
	if [[ -f "$VAULT_INIT_FILE" ]]; then
		echo "Error: Vault is already initialized ($VAULT_INIT_FILE exists)"
		exit 1
	fi

	if ! init_output=$(v vault operator init); then
		echo "Error: Vault operator init failed"
		echo "$init_output"
		exit 1
	fi

	echo "$init_output"
	printf '%s\n' "$init_output" >"$VAULT_INIT_FILE"
}

configure() {
	token="$1"

	v vault login "$token"
	v vault secrets enable -path=secret kv-v2
	v vault auth enable kubernetes
	v vault write auth/kubernetes/config kubernetes_host="https://kubernetes.default.svc.cluster.local:443"
}

usage() {
	echo "Usage:"
	echo "  secrets/vault-init.sh init"
	echo "  secrets/vault-init.sh configure <token>"
	exit 1
}

case "${1:-}" in
init)
	init
	;;
configure)
	configure "$2"
	;;
*)
	usage
	;;
esac
