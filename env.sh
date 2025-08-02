#!/bin/bash

find ./ -type f -name ".env" -exec rm {} \;
cp ./env.sample ./.env

export DBROOTPASSWORDX=$(curl --silent https://randomuser.me/api/ | jq '.results[].login.salt')
export DBAPPUSERX=$(curl --silent https://randomuser.me/api/ | jq '.results[].login.password')
export DBAPPPASSWORDX=$(curl --silent https://randomuser.me/api/ | jq '.results[].login.salt')
export PASSYBACKUPX=$(curl --silent https://randomuser.me/api/ | jq '.results[].login.salt')

sed -i~ "/^DB_ROOTPASSWORD=/s/=.*/=$DBROOTPASSWORDX/" ./.env
sed -i~ "/^DB_APPUSER=/s/=.*/=$DBAPPUSERX/" ./.env
sed -i~ "/^DB_APPPASS=/s/=.*/=$DBAPPPASSWORDX/" ./.env
sed -i~ "/^BACKUP_PASS=/s/=.*/=$PASSYBACKUPX/" ./.env

if [[ "$OSTYPE" == "darwin"* ]]; then
    SED_INPLACE="sed -i ''"
else
    SED_INPLACE="sed -i"
fi

eval "$SED_INPLACE 's/\"//gI' ./.env"

rm ./.env~

