#!/bin/bash

. ./scripts/run-docker-compose.sh
source ./scripts/load-environment-variables.sh
source ./scripts/create-mosquitto-conf.sh

for ((i=1;i<=$#;i++)); 
do

    if [ ${!i} = "--env-file" ] || [ ${!i} = "-e" ]
    then ((i++)) 
        ENV_FILE=${!i};

    # elif [ ${!i} = "-t" ]
    # then ((i++)) 
    #     TO_VAL=${!i};  

    # elif [ ${!i} = "-v" ]
    # then ((i++)) 
    #     TEST_VAL=${!i};  

    fi

done;

ARGUMENTS="-f docker-compose.yml"

if [ -z "$ENV_FILE" ]
then
	ARGUMENTS+=" --env-file $ENV_FILE"
fi

if [[ $CLOUD_LOCAL != "true" ]]
then
	ARGUMENTS+=" --profile nginx"
fi

ARGUMENTS+=" up"

run_docker_compose $ARGUMENTS