#/bin/bash

TOKEN=${1}
if [[ -z $TOKEN ]]
then
  echo "please provide a session token"
  exit 1
fi
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN
CREDS=$(aws sts get-session-token --serial-number arn:aws:iam::640753244498:mfa/Chai_inQuisitive --token-code $TOKEN --duration-seconds 14400 --output json | jq .Credentials )
if [[ -z $CREDS ]]
then
  echo "Invalid token. Access Denied"
  exit 1
fi
AWS_ACCESS_KEY_ID=$(echo $CREDS | jq -r .AccessKeyId)
AWS_SECRET_ACCESS_KEY=$(echo $CREDS | jq -r .SecretAccessKey)
AWS_SESSION_TOKEN=$(echo $CREDS | jq -r .SessionToken)
echo "export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" >> tmp.env
echo "export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" >> tmp.env
echo "export AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN" >> tmp.env
echo "creds are set in ENVIRONMENT VARS"

CRED_FILE_NAME=~/.aws/credentials
OUTPUT_FILE=()
readarray -t CRED_FILE < "${CRED_FILE_NAME}"
for LINE in "${CRED_FILE[@]}"
do
  OUTPUT_FILE+=( "${LINE}" )
  if [[ "${#OUTPUT_FILE[@]}" >1 && "${OUTPUT_FILE[-2]}" = "[MFA]" ]]
  then
    unset OUTPUT_FILE[-1]
  fi
  if [[ "${OUTPUT_FILE[-1]}" = "[MFA]" && -z $LINE ]]
  then
    OUTPUT_FILE+=( "aws_access_key_id=${AWS_ACCESS_KEY_ID}" )
    OUTPUT_FILE+=( "aws_secret_access_key=${AWS_SECRET_ACCESS_KEY}" )
    OUTPUT_FILE+=( "aws_session_token=${AWS_SESSION_TOKEN}" )
    OUTPUT_FILE+=( "${LINE}" )
  fi
done

printf "%s\n" "${OUTPUT_FILE[@]}" > "${CRED_FILE_NAME}"
echo "profile [MFA] updated ~./aws/credentials as profile"





