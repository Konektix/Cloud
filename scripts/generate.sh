#!/bin/bash

for ((i=1;i<=$#;i++)); 
do

	if [ ${!i} = "--password" ] || [ ${!i} = "-p" ]
	then ((i++)) 
		PASSWORD=${!i};

	elif [ ${!i} = "--domain" ] || [ ${!i} = "-d" ]
	then ((i++)) 
		DOMAIN=${!i}; 
	fi

done;

if [ -z $PASSWORD ] || [ -z $DOMAIN ]
then
	echo "ERROR: password and domain must be defined."
	exit 1
fi

echo "The domain: $DOMAIN"

DIRECTORY=certs

mkdir -p $DIRECTORY

openssl genrsa -des3 -passout pass:$PASSWORD -out $DIRECTORY/ca.key 2048

openssl req -passin pass:$PASSWORD -new -key $DIRECTORY/ca.key -out $DIRECTORY/ca-cert-request.csr -sha256 -subj "/O=Widgets Inc"

openssl x509 -req -passin pass:$PASSWORD -in $DIRECTORY/ca-cert-request.csr -signkey $DIRECTORY/ca.key -out $DIRECTORY/ca-root-cert.crt -days 365 -sha256

openssl genrsa -out $DIRECTORY/server.key 2048

openssl req -new -key $DIRECTORY/server.key -out $DIRECTORY/server-cert-request.csr -sha256 -subj "/O=MQTT Broker Inc./CN=$$DOMAIN"

openssl x509 -req -in $DIRECTORY/server-cert-request.csr -CA $DIRECTORY/ca-root-cert.crt -passin pass:$PASSWORD -CAkey $DIRECTORY/ca.key -CAcreateserial -out $DIRECTORY/server.crt -days 360