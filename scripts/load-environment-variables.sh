#!/bin/bash

ENV_FILE=.env

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

echo "Environemnt variables file: $ENV_FILE"

if [ -e $ENV_FILE ]
then
    source ./$ENV_FILE
else
	echo "Environemnt variables file not found: $ENV_FILE"
fi

