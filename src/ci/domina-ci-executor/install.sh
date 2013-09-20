VERSION=$1
TARGET_DIR="${HOME}/domina_ci_executor"
rm -rf "${TARGET_DIR}" \
&& git clone https://github.com/DrTom/domina-ci-executor.git ${TARGET_DIR} \
&& cd "$TARGET_DIR" \
&& git fetch --all \
&& if [ -n $VERSION ]; then
  git checkout $VERSION
fi
