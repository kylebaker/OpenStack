sudo yum install epel-release -y
sudo yum install ruby-devel libvirt-devel zlib-devel libpng-devel gcc qemu-kvm qemu-img libvirt libvirt-python libvirt-client virt-install bridge-utils git -y
sudo yum install https://releases.hashicorp.com/vagrant/2.2.5/vagrant_2.2.5_x86_64.rpm -y
vagrant plugin install vagrant-hostmanager
vagrant plugin install --plugin-version ">= 0.0.31" vagrant-libvirt

sudo gpasswd -a ${USER} libvirt
newgrp libvirt
sudo systemctl disable firewalld
sudo systemctl start nfs-server
sudo systemctl start rpcbind.service
sudo systemctl enable libvirtd --now

#SKIP THIS changes location of VM
# configure libvirtd default storage location
sudo virsh pool-define-as --name default --type dir --target /home
sudo virsh pool-autostart default
sudo virsh pool-start default

cat << EOF > /etc/sysconfig/network-scripts/ifcfg-internal0
DEVICE="internal0"
BOOTPROTO="static"
ONBOOT="yes"
TYPE="Bridge"
NM_CONTROLLED="no"
IPV6INIT="no"
IPV6_AUTOCONF="no"
EOF