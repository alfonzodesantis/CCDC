###Ubuntu18

##Installing and Activating AppArmor
sudo apt-get install upgrade && update -yuf
sudo apt-get install apparmor-utils apparmor-profiles apparmor-profiles-extra -y
sudo systemctl enable apparmor
sudo systemctl start apparmor
sudo aa-enforce /etc/apparmor.d/*

##Installing and Activating ModSecurity
sudo apt-get install libapache2-mod-security2 -y
##Check if ModSecurity success (security2_modue (shared))
#sudo apachectl -M | grep --color security2
sudo mv /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf
##Reload Apache2
sudo service apache2 reload
##Turning on SecRuleEngine
sudo sed -i "s/SecRuleEngine DetectionOnly/SecRuleEngine On/" /etc/modsecurity/modsecurity.conf
##Replace ModSecurity folder with OWASP's modsecurity config
sudo apt-get install git
sudo mv /usr/share/modsecurity-crs /usr/share/modsecurity-crs.bk
sudo git clone https://github.com/SpiderLabs/owasp-modsecurity-crs.git /usr/share/modsecurity-crs
sudo cp /usr/share/modsecurity-crs/crs-setup.conf.example /usr/share/modsecurity-crs/crs-setup.conf
##Patch /etc/apache2/mods-enabled/security2.conf
##  Might have to clobber
#sudo patch -l security2.conf ~/security2.patch
##or
#sudo rm -rf /etc/apache2/mods-enabled/security2.conf
#sudo mv security2.conf /etc/apache2/mods-enabled/security2.conf
sudo systemctl restart apache2

##Patch sshd.config

##Check accounts for Empty passwords
sudo cat /etc/shadow | awk -F: '($2==""){print $1}' > ~/emptypasswords.txt

##Disable IPv6
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
sudo sysctl -p



##Patch Network to
