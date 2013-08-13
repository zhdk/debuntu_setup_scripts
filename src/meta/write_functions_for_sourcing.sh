FUNLIST=`declare -F | grep -e "^declare -f debuntu" | cut -f3 -d ' '`
FUNCTIONS=`declare -f $FUNLIST`
echo "$FUNCTIONS" > "$1"
