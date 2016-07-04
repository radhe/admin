#!/bin/bash


# Error handling
function error()
{
	echo -e "[ `date` ] $(tput setaf 1)$@$(tput sgr0)"
	exit $2
}

# Unhide Startup
sed -i "s/NoDisplay=true/NoDisplay=false/g" /etc/xdg/autostart/*.desktop

# Execute: apt-get update
apt-get update \
|| error "Unable to execute apt-get update command, exit status = " $?

# Google Repository
echo "Adding google-chrome repository, please wait..."
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - \
&& sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
|| ee_lib_error "Unable to add google-chrome repository, exit status = " $?

# Shutter Repository
echo "Adding shutter repository, please wait..."
sudo add-apt-repository -y ppa:shutter/ppa \
|| ee_lib_error "Unable to add shutter repository, exit status = " $?

# Skype Repository 		
echo "Adding skype repository, please wait..."		
sudo sh -c  'echo "deb http://archive.canonical.com/ubuntu/ $(lsb_release -sc) partner" >> /etc/apt/sources.list.d/canonical_partner.list' || ee_lib_error "Unable to add skype repository, exit status = " $?

#NodeJs Repository
clear
echo "Install Repository For NodeJs..."
sudo add-apt-repository -y ppa:chris-lea/node.js || ee_lib_error "Unable to add NodeJS repository, exit status = " $?

# Execute: apt-get update
apt-get update \
|| error "Unable to execute apt-get update command, exit status = " $?

# Update System
apt-get -y upgrade

# Install required packages
echo "Installing necessary packages, please wait..."
apt-get -y install curl wget git openssh-server shutter google-chrome-stable vlc skype diodon nautilus-open-terminal ruby2.0 ruby2.0-dev ruby2.0-doc nodejs || error "Unable to install required packages, exit status = " $?

#Install SASS
clear
echo "Install SASS"
sudo gem install sass || ee_lib_error "Unable to add SASS, exit status = " $?

#Install Compass
clear
echo "Install Compass"
sudo gem install compass || ee_lib_error "Unable to add Compass, exit status = " $?

#Install Foundation
clear
echo "Install Foundation"
sudo gem install foundation || ee_lib_error "Unable to add Foundation, exit status = " $?

#Install Grunt CLI
clear
echo "Install Grunt"
sudo npm install -g grunt-cli || ee_lib_error "Unable to add Grunt, exit status = " $?

#Install Bower
clear
echo "Install Bower"
sudo npm install -g bower || ee_lib_error "Unable to add Bower, exit status = " $?

#Install Netbeans
clear
echo "Downloading Netbeans..."
wget -c download.netbeans.org/netbeans/8.1/final/bundles/netbeans-8.1-php-linux-x64.sh || ee_lib_error "Unable to download Netbeans, exit status = " $?
chmod u+x netbeans-8.1-php-linux-x64.sh
echo "Installing Netbeans..."
sudo bash netbeans-8.1-php-linux-x64.sh || ee_lib_error "Unable to install Netbeans, exit status = " $?
clear

#Install Web Server
wget -qO ee rt.cx/ee && sudo bash ee || ee_lib_error "Unable to install ee, exit status = " $?
source /etc/bash_completion.d/ee || ee_lib_error "Unable to source ee autocompletion, exit status = " $?
echo
echo "All Task Susscessfully Finished........"
