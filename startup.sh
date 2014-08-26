#!/bin/bash

USER=ubuntu
PASSWORD=ubuntu
#LANG=ja_JP.UTF-8
#TZ=JST-9
LANG=en_US.UTF-8
TZ=
if [ ! -d /home/${USER} ] ; then
  useradd -m -k /etc/skel -s /bin/bash  ${USER}
  echo "${USER}:${PASSWORD}" |chpasswd
  usermod -a --group sudo ubuntu
  echo "export LANG=${LANG}" > /home/${USER}/.xsessionrc
  echo "export TZ=${TZ}" >> /home/${USER}/.xsessionrc
  chmod 755  /home/${USER}/.xsessionrc
  chown ${USER}.${USER}  /home/${USER}/.xsessionrc
  su -c "im-config -n scim" ${USER}
fi
if [ -f /var/run/xdm.pid ] ; then
  rm /var/run/xdm.pid
fi

service xdm start
# Start the ssh service
/usr/sbin/sshd -D
#service ssh restart

#/bin/bash
