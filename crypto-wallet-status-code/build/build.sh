#!/bin/sh -e
# crypto-wallet-status build.sh

echo " "

if [ "$1" = "-debug" ]
then
    echo "************************************************************************"
    echo "* build.sh -debug (START) **********************************************"
    echo "************************************************************************"
    # set -x enables a mode of the shell where all executed commands
    # are printed to the terminal.
    set -x
    echo " "
else
    echo "************************************************************************"
    echo "* build.sh (START) *****************************************************"
    echo "************************************************************************"
    echo " "
fi

echo "cd to where go code is"
echo "cd .."
cd ..
echo " " 

echo "Build your docker image using Dockerfile"
echo "NOTE: The binary is built using this step"
echo "docker build -f build/Dockerfile -t jeffdecola/crypto-wallet-status ."
docker build -f build/Dockerfile -t jeffdecola/crypto-wallet-status .
echo " "

echo "Check Docker Image size"
echo "docker images jeffdecola/crypto-wallet-status:latest"
docker images jeffdecola/crypto-wallet-status:latest
echo " "

echo "Useful commands:"
echo "     docker run --name crypto-wallet-status -dit jeffdecola/crypto-wallet-status"
echo "     docker exec -i -t crypto-wallet-status /bin/bash"
echo "     docker logs crypto-wallet-status"
echo " "

echo "************************************************************************"
echo "* build.sh (END) *******************************************************"
echo "************************************************************************"
echo " "
