#!/bin/bash

echo
echo " ____    _____      _      ____    _____ "
echo "/ ___|  |_   _|    / \    |  _ \  |_   _|"
echo "\___ \    | |     / _ \   | |_) |   | |  "
echo " ___) |   | |    / ___ \  |  _ <    | |  "
echo "|____/    |_|   /_/   \_\ |_| \_\   |_|  "
echo
echo "Deploying Chaincode Autonet On Automobile Registration Network"
echo
CHANNEL_NAME="$1"
DELAY="$2"
LANGUAGE="$3"
VERSION="$4"
TYPE="$5"
: ${CHANNEL_NAME:="registrationchannel"}
: ${DELAY:="5"}
: ${LANGUAGE:="node"}
: ${VERSION:=1.1}
: ${TYPE="basic"}

LANGUAGE=`echo "$LANGUAGE" | tr [:upper:] [:lower:]`
ORGS="partsFactory carFactory dealer"
TIMEOUT=15

if [ "$TYPE" = "basic" ]; then
  CC_SRC_PATH="/opt/gopath/src/github.com/hyperledger/fabric/peer/chaincode/"
else
  CC_SRC_PATH="/opt/gopath/src/github.com/hyperledger/fabric/peer/chaincode-advanced/"
fi

echo "Channel name : "$CHANNEL_NAME

# import utils
. scripts/utils.sh

## Install new version of chaincode on peer0 of all 3 orgs making them endorsers
echo "Installing chaincode on peer0.partsFactory.automobile-registration-network.com ..."
installChaincode 0 'partsFactory' $VERSION
echo "Installing chaincode on peer0.carFactory.automobile-registration-network.com ..."
installChaincode 0 'carFactory' $VERSION
echo "Installing chaincode on peer0.dealer.automobile-registration-network.com ..."
installChaincode 0 'dealer' $VERSION

# Instantiate chaincode on the channel using peer0.partsFactory
echo "Instantiating chaincode on channel using peer0.partsFactory.automobile-registration-network.com ..."
instantiateChaincode 0 'partsFactory' $VERSION

echo
echo "========= All GOOD, Chaincode Autonet Is Now Installed & Instantiated On Automobile Registration Network =========== "
echo

echo
echo " _____   _   _   ____   "
echo "| ____| | \ | | |  _ \  "
echo "|  _|   |  \| | | | | | "
echo "| |___  | |\  | | |_| | "
echo "|_____| |_| \_| |____/  "
echo

exit 0
