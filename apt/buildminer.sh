#!/bin/bash
#This script will install monero with all of it's requirements.

echo "Will build CPUMiner. CPUMiner supports pool mining for multiple algos, including CryptoNight. Do you want to build it now	[y/n]?"

	cd ~
	
	#Installing required packages
	echo "Installing required packages"
	sudo apt-get install -y automake libcurl4-openssl-dev pkg-config
	sudo apt-get update

	
	#Building CPUMiner
	
	git clone https://github.com/wolf9466/cpuminer-multi 
	pushd cpuminer-multi
	

	./autogen.sh
	CFLAGS="-march=native" ./configure --disable-aes-ni
	
	
	#Building with maximum number of cores
	n=$(nproc)
	if [$n !== 1] 
	then
		$n = $n / 2
		make -j $n
	else
		make
	fi
	
	#Unsetting flag and leaving dir
	
	popd
	sudo make install
	echo "Finished building"
