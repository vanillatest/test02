#FROM centos:centos6
#FROM base/archlinux
FROM pritunl/archlinux

# ENV http(s)_proxy="http://_:_"

run echo "#!/bin/bash" > /etc/profile.d/aliass.sh
run echo -e "alias ll='ls -alh'\nalias l=ll\nalias lll=ll" >> /etc/profile.d/aliass.sh
run echo "alias dush='du -sh'" >> /etc/profile.d/aliass.sh

run echo "export TZ=America/Los_Angeles" >> /etc/profile
#RHEL# run sed -i "s:^ZONE=.*:ZONE=\"America/Los_Angeles\":" /etc/sysconfig/clock
#RHEL# run sed -i "s:^UTC=.*:UTC=false:" /etc/sysconfig/clock
run ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
