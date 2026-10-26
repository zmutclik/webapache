#!/bin/bash

rm -f ./.env
cp ./env.sample ./.env

DBROOTPASSWORDX=$(openssl rand -hex 16)
DBAPPUSERX=user_$(openssl rand -hex 4)
DBAPPPASSWORDX=$(openssl rand -hex 16)
PASSYBACKUPX=$(openssl rand -hex 16)

sed -i~ "/^DB_ROOTPASSWORD=/s/=.*/=$DBROOTPASSWORDX/" ./.env
sed -i~ "/^DB_APPUSER=/s/=.*/=$DBAPPUSERX/" ./.env
sed -i~ "/^DB_APPPASS=/s/=.*/=$DBAPPPASSWORDX/" ./.env
sed -i~ "/^BACKUP_PASS=/s/=.*/=$PASSYBACKUPX/" ./.env

rm -f ./.env~
