#!/bin/sh

########
# 
# This script is a test script to attempt to fix SSL issues with PhAzE plugins
# 
########

# Step 1 - Download PERL
cd /tmp
wget http://slackware.cs.utah.edu/pub/slackware/slackware-13.37/slackware/d/perl-5.12.3-i486-1.txz

# Step 2 - Download CERTS
wget http://slackware.cs.utah.edu/pub/slackware/slackware-14.1/slackware/n/ca-certificates-20130906-noarch-1.txz

# Step 3 - Install PERL
ROOT="/usr/local/PhAzE-Common" upgradepkg --install-new /tmp/perl-5.12.3-i486-1.txz

# Step 4 - Install CERTS (normal install)
upgradepkg --install-new /tmp/ca-certificates-20130906-noarch-1.txz

# Step 5 - Run update-cert command to install the root certificates
sudo -Hu root /bin/bash -c '. /usr/local/PhAzE-Common/Sickbeard/startcfg.sh; /usr/sbin/update-ca-certificates'

# Step 6 - Edit startcfg.sh for SAB and SickBeard with the following:
echo 'export SSL_CERT_DIR="/etc/ssl/certs"' >> /usr/local/PhAzE-Common/Sickbeard/startcfg.sh
echo 'export SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"' >> /usr/local/PhAzE-Common/Sickbeard/startcfg.sh
echo 'export SSL_CERT_DIR="/etc/ssl/certs"' >> /usr/local/PhAzE-Common/Sabnzbd/startcfg.sh
echo 'export SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"' >> /usr/local/PhAzE-Common/Sabnzbd/startcfg.sh
