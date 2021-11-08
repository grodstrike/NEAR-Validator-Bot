#!/bin/bash
echo "
+----------------------------------------------------------------------
| PING NEAR VALIDATOR INSTALL
| Version: 0.2 (08/11/2021)
+----------------------------------------------------------------------
| Copyright © 2015-2021 All rights reserved.
+----------------------------------------------------------------------
| 
+----------------------------------------------------------------------
";sleep 5

homedir=$HOME

echo "Enter your pool (example: nearvalidator.pool.f863973.m0)"
read n
echo "Enter NEAR NETWORK (example: testnet)"
read m
echo 'Enter your account (example: NEARVALIDATOR.testnet)'
read s

cat >> $homedir/ping.sh << EOF
#!/bin/bash
export NEAR_ENV=$m
ACCOUNT=$s
POOL=$n
D=$(date  +%Y-%m-%d)
T=$(date +%H:%M:%S)
echo "$D" "$T"
near call $n ping '{}' --accountId $s --gas=300000000000000
EOF

chmod +x $homedir/ping.sh

# Adding to Cron
crontab -l > mycron
# echo new cron into cron file
echo "0 */1 * * * $homedir/ping.sh >> homedir/near.log 2&1" >> mycron
# install new cron file
crontab mycron
rm -f mycron

echo "Ping Installed!"