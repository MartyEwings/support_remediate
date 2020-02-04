#!/bin/sh

# Puppet Task Name: cve_2019_18634
#
#

var=$(sudo -l | grep pwfeedback)


if test -z "$var"
then
      echo "Not Vulnerable to CVE-2019-18634"
else
      echo "Vulnerable to CVE-2019-18634 removing pwfeedback"
      sed -e s/,pwfeedback//g -i /etc/sudoers
fi

