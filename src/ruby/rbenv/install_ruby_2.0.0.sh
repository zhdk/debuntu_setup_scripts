#!/bin/bash

# $1 == KEEP ; do not force to reinstall from scratch
# $2 == REMOVE-PREVIOUS ; remove all previous patch versions

CURRENT='2.0.0-p247'
LINK='ruby-2.0.0'
declare -a OLD_VERSIONS=("2.0.0-p0" "2.0.0-p195")

VESIONS_DIR="${HOME}"/.rbenv/versions

if [ "$2" == "REMOVE-PREVIOUS" ]; then
  for V in ${OLD_VERSIONS[@]}; do
    removing $V
    rm -rf  "$VERSIONS"/"${V}"
  done 
fi 

if [ "$1" == "KEEP" ]; then
  if [ ! -d "$VERSIONS"/"$CURRENT" ]; then
    debuntu_ruby_rbenv_install_ruby "$CURRENT" "$LINK"
  fi
else
  rm -rf "$VERSIONS"/"$CURRENT"
  debuntu_ruby_rbenv_install_ruby "$CURRENT" "$LINK"
fi
