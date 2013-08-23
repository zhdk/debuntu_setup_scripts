# $1 == KEEP ; do not force to reinstall from scratch
# $2 == REMOVE-PREVIOUS ; remove all previous patch versions

CURRENT='1.9.3-p448'
LINK='ruby-1.9.3'
declare -a OLD_VERSIONS=("1.9.3-p0" "1.9.3-p125" "1.9.3-p194"  \
    "1.9.3-p286" "1.9.3-p327" "1.9.3-p362" "1.9.3-p374" "1.9.3-p385" \
    "1.9.3-p392" "1.9.3-p429")

VERSIONS_DIR="${HOME}"/.rbenv/versions

echo $1
echo $2

if [ "$1" == "KEEP" ]; then
  if [ ! -d "${VERSIONS_DIR}/${CURRENT}" ]; then
     debuntu_ruby_rbenv_install_ruby "$CURRENT" "$LINK"
   else
     echo "Found and keeping ${CURRENT}"
  fi
else
  rm -rf "${VERSIONS_DIR}/${CURRENT}"
  debuntu_ruby_rbenv_install_ruby "$CURRENT" "$LINK"
fi

if [ "$2" == "REMOVE-PREVIOUS" ]; then
  for V in ${OLD_VERSIONS[@]}; do
    if [ ! -d "${VERSIONS_DIR}/${V}" ]; then
      echo "removing $V"
      rm -rf  "$VERSIONS_DIR"/"${V}"
    fi
  done 
fi 

