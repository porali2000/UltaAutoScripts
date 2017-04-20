#!/bin/bash

source $(dirname $0)/init.sh

echo store-$store

if test -z $store; then
		$(getStore)	
fi
	
echo "$(test -z $store)"