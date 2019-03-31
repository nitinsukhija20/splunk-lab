#!/bin/bash
#
# Wrapper script to set up Splunk Lab
#
# To test this script out, set up a webserver:
# 
#	python -m SimpleHTTPServer 8000
#
# Then run the script:
#
#	bash <(curl -s localhost:8000/go.sh)
#


# Errors are fatal
set -e


#
# Set default values for our 
#
SPLUNK_PASSWORD=${SPLUNK_PASSWORD:-password}
SPLUNK_DATA=${SPLUNK_DATA:-data}
SPLUNK_LOGS=${SPLUNK_LOGS:-logs}
SPLUNK_PORT=${SPLUNK_PORT:-8000}
SPLUNK_APP="app"
SPLUNK_BG=${SPLUNK_BG:-1}
SPLUNK_DEVEL=${SPLUNK_DEVEL:-}


if ! test $(which docker)
then
	echo "! "
	echo "! Docker not found in the system path!"
	echo "! "
	echo "! Please double-check that Docker is installed on your system, otherwise you "
	echo "! can go to https://www.docker.com/ to download Docker. "
	echo "! "
	exit 1
fi


#
# Sanity check to make sure our log directory exists
#
if test ! -d "${SPLUNK_LOGS}"
then
	echo "! "
	echo "! ERROR: Log directory '${SPLUNK_LOGS}' does not exist!"
	echo "! "
	echo "! Please set the environment variable \$SPLUNK_LOGS to the "
	echo "! directory you wish to ingest and re-run this script."
	echo "! "
	exit 1
fi

if test "$SPLUNK_DEVEL"
then
	#
	# This wacky check for $SPLUNK_BG is here because setting it
	# an empty string causes it to "default" to 1.  Silly bash!
	#
	if test "$SPLUNK_BG" -a "$SPLUNK_BG" != 0
	then
		echo "! "
		echo "! You cannot specify both SPLUNK_DEVEL and SPLUNK_BG!"
		echo "! "
		exit 1
	fi
fi


#
# Now create our props.conf if it doesn't exist...
#
if test ! -f ${SPLUNK_APP}/props.conf
then
	echo "# ${SPLUNK_APP}/props.conf does not exist!  Creating it..."
	mkdir -p ${SPLUNK_APP}
	cat << EOF > $SPLUNK_APP/props.conf
#
# Apply this to everything in /logs/
#
[source::/logs/*]
#
# We have one record per line.
#
SHOULD_LINEMERGE = false

#
# Allow events as old as 30 years in the past.
#
MAX_DAYS_AGO=10951

EOF

fi


#
# Start forming our command
#
CMD="docker run \
	-p ${SPLUNK_PORT}:8000 \
	-e SPLUNK_PASSWORD=${SPLUNK_PASSWORD} \
	-v $(pwd)/${SPLUNK_DATA}:/data \
	-v $(pwd)/${SPLUNK_APP}:/app "


#
# If the logs value doesn't start with a leading slash, prefix it with the full path
#
if test ${SPLUNK_LOGS:0:1} != "/"
then
	SPLUNK_LOGS="$(pwd)/${SPLUNK_LOGS}"
fi

CMD="${CMD} -v ${SPLUNK_LOGS}:/logs"

if test "$SPLUNK_BG" -a "$SPLUNK_BG" != 0
then
	CMD="${CMD} -d "
fi

if test "$SPLUNK_DEVEL"
then
	CMD="${CMD} -it"
	CMD="${CMD} -v $(pwd):/mnt "
fi

CMD="${CMD} dmuth1/splunk-lab"

if test "$SPLUNK_DEVEL"
then
	CMD="${CMD} bash"
fi

echo "# "
if test ! "${SPLUNK_DEVEL}"
then
	echo "# About to run Splunk Lab!"
else
	echo "# About to run Splunk Lab IN DEVELOPMENT MODE!"
fi
echo "# "
echo "# Before we do, please take a few seconds to ensure that your options are correct:"
echo "# "
echo "# URL:                               https://localhost:${SPLUNK_PORT}"
echo "# Login/password:                    admin/${SPLUNK_PASSWORD}"
echo "# "
echo "# Logs will be read from:            ${SPLUNK_LOGS}"
echo "# App dashboards will be stored in:  ${SPLUNK_APP}"
echo "# Indexed data will be stored in:    ${SPLUNK_DATA}"
echo "# "
if test "$SPLUNK_BG" -a "$SPLUNK_BG" != 0
then
echo "# Background Mode?                   YES"
else 
echo "# Background Mode?                   NO"
fi
echo "# "
echo "# "
echo "# The above configuration settings can be changed by setting these environment variables:"
echo "# "
echo "# - \$SPLUNK_PASSWORD"
echo "# - \$SPLUNK_PORT"
echo "# - \$SPLUNK_LOGS"
echo "# - \$SPLUNK_APP"
echo "# - \$SPLUNK_DATA"
echo "# - \$SPLUNK_BG - Set to any value to run the container in the background. Set to empty to run in the foreground."
echo "# "

echo "> "
echo "> Press ENTER to run Splunk Lab with the above settings, or ctrl-C to abort..."
echo "> "
read


echo "# "
echo "# Launching container..."
echo "# "

if test ! "$SPLUNK_BG" -o "$SPLUNK_BG" == 0
then
	$CMD

else
	ID=$($CMD)
	SHORT_ID=$(echo $ID | cut -c-4)
	echo "#"
	echo "# Running Docker container with ID: ${ID}"
	echo "#"
	echo "# Inspect container logs with: docker logs ${SHORT_ID}"
	echo "#"
	echo "# Kill container with: docker kill ${SHORT_ID}"
	echo "#"

fi


