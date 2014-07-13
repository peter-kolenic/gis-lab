#
### FILE SERVER - NFS ###
#

# packages installation
GISLAB_SERVER_INSTALL_PACKAGES="
  nfs-kernel-server
  pgadmin3
"
apt-get --assume-yes --force-yes --no-install-recommends install $GISLAB_SERVER_INSTALL_PACKAGES


mkdir -p /storage/repository    # readable for all, writable only for labadmins
chown root:labadmins /storage/repository
chmod 775 /storage/repository

mkdir -p /storage/share         # readable for all, writable for file owners or labadmins
chown root:labadmins /storage/share
chmod 775 /storage/share

mkdir -p /storage/barrel        # readable and writable for all labusers
chown root:nogroup /storage/barrel
chmod 775 /storage/barrel

# NFS share exports
LAB1_UID=$(id -u lab1 2> /dev/null || echo 3000)
LAB1_GID=$(id -g lab1 2> /dev/null || echo 3001)
cat $GISLAB_INSTALL_CURRENT_ROOT/conf/nfs/exports | sed -e "s/\<GISLAB_NETWORK\>/$GISLAB_NETWORK/g" -e "s/\<LAB1_UID\>/$LAB1_UID/g" -e "s/\<LAB1_GID\>/$LAB1_GID/g" > /etc/exports
gislab_config_header_to_file /etc/exports

# user IDs mapping
cp $GISLAB_INSTALL_CURRENT_ROOT/conf/nfs/idmapd.conf /etc/idmapd.conf
gislab_config_header_to_file /etc/idmapd.conf


# add /mnt mount point to fstab
if [ ! -f "/var/lib/gislab/$GISLAB_INSTALL_CURRENT_SERVICE.done" ]; then
	cat << EOF >> /etc/fstab
$(gislab_config_header)
/storage  /mnt  none  bind  0  0
EOF
fi

umount /mnt || true				# for sure try to umount first (some AWS instances can boot with
								# /mnt already occupied)
mount -o bind /storage /mnt		# bind mount to keep the same paths on server as on client

service nfs-kernel-server restart
service idmapd restart


# vim: set syntax=sh ts=4 sts=4 sw=4 noet:
