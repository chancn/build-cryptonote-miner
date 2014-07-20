#!/bin/bash
#This script will install monero with all of it's requirements.

#Installing general requirements
sudo apt-get update
sudo apt-get -y install python-software-properties
sudo apt-get update
sudo apt-get -y install gcc-4.8 g++-4.8 rlwrap git cmake build-essential
sudo apt-get -y install libboost1.55-all-dev

    
		# Find the number of available hardware threads
		n=$(nproc)

#############################################################
#Installing Wolf's CPUMiner. A fast pool miner utilizing AES
#############################################################


	echo "The following part will build CPUMiner. CPUMiner supports pool mining for multiple algos, including CryptoNight. Do you want to build it now	[y/n]?"

	cd ~
	
	#Installing required packages
	echo "Installing required packages"
	sudo apt-get install -y automake libcurl4-openssl-dev pkg-config
	
	#Preparing

	mkdir cpuminer
	cd cpuminer

		git clone https://github.com/wolf9466/cpuminer-multi 
		pushd cpuminer-multi
	
	./autogen.sh
	export CFLAGS="-march=native"
	./configure
	
	#Building with maximum number of cores
	n=$(nproc)
	if [$n !== 1] 
	then
		$n = $n / 2
		make -j $n
	else
		make
	fi
	
	sudo make install

	#Unsetting flag and leaving dir
	unset CFLAGS
	popd
	
	echo "Finished building"

echo "The script has finished"