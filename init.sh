#!/bin/bash

export store=""
export reg=""
export tran=""

function getStore(){
	if test -z $store; then
		read -p 'Enter Store# = ' $store	
	fi
	store=$store
	return $store
}
