#!/bin/bash

######################################################################################
#
# Description:
# ------------
#	Set static ARP entries defined in UDM Pro ARP table.
#
######################################################################################

######################################################################################
#
# Configuration
#

# directory with sarp config files. All *.conf files in the directory will be considered 
# as valid static arp entries.
conf_dir="/data/custom/sarp/"

#
# No further changes should be necessary beyond this line.
#
######################################################################################


# set scriptname
me=$(basename $0)

echo "$(dirname $0)/${me%.*}.conf"

# include local configuration if available
[ -e "$(dirname $0)/${me%.*}.conf" ] && source "$(dirname $0)/${me%.*}.conf"

for conf_file in ${conf_dir}/*.conf; do

    if [ $(basename $conf_file) != "${me%.*}.conf" ]; then

        while read a; do
             [[ $a =~ ^#.* ]] && continue
             arp -s $a
        done <$conf_file

    fi
done
