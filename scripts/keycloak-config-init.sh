#!/bin/bash

echo "Initialize Keycloak configuration"

./opt/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080 --realm master --user $KEYCLOAK_ADMIN --password $KEYCLOAK_ADMIN_PASSWORD

# ./opt/keycloak/bin/kcadm.sh create realms -s realm=$KEYCLOAK_REALM -s enabled=true

declare -A secretsByClientIds

secretsByClientIds[iot-data-hub]=$KEYCLOAK_IOT_DATA_HUB_SECRET
secretsByClientIds[hub-manager]=$KEYCLOAK_HUB_MANAGER_SECRET

for key in ${!secretsByClientIds[@]}; do
	CLIENT_ID=${key}
	SECRET=${secretsByClientIds[${key}]}
    
	./opt/keycloak/bin/kcadm.sh create clients -r $KEYCLOAK_REALM -s clientId=$CLIENT_ID -s enabled=true -s clientAuthenticatorType=client-secret -s secret=$SECRET -s 'redirectUris=["*"]'  -s serviceAccountsEnabled=true
done


# ./opt/keycloak/bin/kcadm.sh create clients -r $KEYCLOAK_REALM -s clientId=iot-data-hub -s enabled=true -s clientAuthenticatorType=client-secret -s secret=$KEYCLOAK_IOT_DATA_HUB_SECRET -s 'redirectUris=["*"]'  -s serviceAccountsEnabled=true

# ./opt/keycloak/bin/kcadm.sh create clients -r $KEYCLOAK_REALM -s clientId=hub-manager -s enabled=true -s clientAuthenticatorType=client-secret -s secret=$KEYCLOAK_HUB_MANAGER_SECRET -s 'redirectUris=["*"]'  -s serviceAccountsEnabled=true

# ./opt/keycloak/bin/kcadm.sh get clients -r konektix_realm --fields id,clientId