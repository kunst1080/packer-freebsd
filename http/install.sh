export ZFSBOOT_DISKS=ada0
export nonInteractive="YES"
DISTRIBUTIONS="base.txz kernel.txz"

#!/bin/sh

set -e

### Edit loader.conf
cat <<EOS>> /boot/loader.conf
autoboot_delay="2"
EOS

### Edit resolv.conf
cat <<EOS>> /etc/resolv.conf
nameserver 8.8.8.8
EOS

### Edit rc.conf
cat <<EOS>> /etc/rc.conf
hostname="VM-FreeBSD"
keymap="jp.106.kbd"

ifconfig_em0="DHCP"
sshd_enable="YES"
dumpdev="NO"

sendmail_enable="NO"
sendmail_submit_enable="NO"
sendmail_outbound_enable="NO"
sendmail_msp_queue_enable="NO"
EOS

### Install Applications
export ASSUME_ALWAYS_YES=yes
cat <<EOS | xargs pkg install
  sudo
  curl
  bash
EOS

### Add user
echo 'vagrant' | pw useradd -n vagrant -h 0 -m -s /bin/tcsh
echo 'vagrant' | pw usermod root -h 0 -s /bin/tcsh

### Set authorized_keys
mkdir -pm 700 /home/vagrant/.ssh
curl -Lo /home/vagrant/.ssh/authorized_keys \
  'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

### Set sudoers
cat <<EOF > /usr/local/etc/sudoers.d/vagrant
Defaults:vagrant !requiretty
vagrant ALL=(ALL) NOPASSWD: ALL
EOF
chmod 440 /usr/local/etc/sudoers.d/vagrant