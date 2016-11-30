#!/bin/sh
function updateSub()
{
	git submodule init
	git submodule foreach git pull origin master
	git submodule update
}

git submodule foreach --recursive updateSub()
