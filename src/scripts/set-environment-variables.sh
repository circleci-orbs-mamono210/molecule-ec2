TIMESTAMP=$(date --date "9 hours" "+%Y%m%d_%H:%M:%S")
VALUE=${PARAM_AWS_RESOURCE_NAME}
AUTHOR_EMAIL=$(git show -s --format='%ae' "${CIRCLE_SHA1}")
echo "export CREATED_BY=${AUTHOR_EMAIL}" >> "${BASH_ENV}"
echo "export KEYPAIR_NAME=${VALUE}_${TIMESTAMP}" >> "${BASH_ENV}"
echo "export PLATFORM_NAME=${VALUE}_${TIMESTAMP}" >> "${BASH_ENV}"
echo "export SECURITY_GROUP_NAME=${VALUE}_${TIMESTAMP}" >> "${BASH_ENV}"
echo "export TAG_NAME=${VALUE}_${TIMESTAMP}" >> "${BASH_ENV}"
source "${BASH_ENV}"
