##!/bin/bash
#
#
#
#
#[ -z "${*}" ] || {
#	echo -n 'Do need uCore Loop (Recursive program load... $0)? [y/N]:'
#	read aLine; echo "${aLine}"
#	[ "${aLine}" == "Y" -o  "${aLine}" == "Yes" -o  "${aLine}" == "yes" -o  "${aLine}" == "y"  ] && {			
#		echo "${*}" | openssl enc -base64 -e  -a  2>/dev/null | xargs echo "TEST" $0 && echo "SUCCESS" && exit 
#	echo "FAILED"
#	 	exit 111		
#		
#	}
#}
# 
# Setup time!
#if [ -z "${1}" ] ; then
#	which ntpdate 2>&1 >/dev/null && sudo ntpdate 10.0.0.1
#else
#	which ntpdate 2>&1 >/dev/null && sudo ntpdate "${1}" || {
#		echo "Your time service failed, trying fallback instead... (time.fu-berlin.de)" 
#		sudo ntpdate time.fu-berlin.de || echo "Fallback time service failed too..." && echo "HINT: Please, ...check your network connection and interconnectivity w/ our services." 
#	}
#fi


echo -n 'Mount storage-node "SECONDARY" [y/N]?: '
read aLine; echo "${aLine}"
[ "${aLine}" == "Y" -o  "${aLine}" == "Yes" -o  "${aLine}" == "yes" -o  "${aLine}" == "y"  ] && {
	# 1st. step #
	sudo mkdir -p /data/SECONDARY && echo "Mountpoint created..."	
	# 2nd. step #
	sudo ln -s /data/SECONDARY /SECONDARY		
	# 3rd. step #
	# 3.1) OFF - for i in /media/desinfect/* ; do sudo mount -o remount,ro $i && echo 'NOTICE 2 U :: "Readonly Remount Successfull done ..."'"$i"; done
	
	# 3.2)
	while true; do sudo mount -t cifs -o username=ro,soft,ro,cache=strict,nosuid,nodev,file_mode=0640,dir_mode=0750,uid=$USER,gid=$USER //192.168.100.2/SECONDARY /data/SECONDARY && break
		echo "...Failed to mount volume. Try again. :-) ...or break w/ [CTRL]+[C]"
	done
	# 4th. step #
	# find /data/SECONDARY -name "_INSTALL" -type d -exec sudo ln -s {} /_INSTALL \;	
	sudo rm -f /_INSTALL	
	[ -d /data/SECONDARY/*/_INSTALL ] && sudo ln -s  /data/SECONDARY/*/_INSTALL /_INSTALL
		
} && echo "...your storage-node is mounted."



SETUPPATH=/_INSTALL
echo -n 'Run common setup.sh (Path: "'"${SETUPPATH}"'") [y/N]?: '
read aLine; echo "${aLine}"
[ "${aLine}" == "Y" -o  "${aLine}" == "Yes" -o  "${aLine}" == "yes" -o  "${aLine}" == "y"  ] && {
	# 1st. step #
	cd "${SETUPPATH}" 
	# 2nd. step #
	sudo ./setup.sh

} && echo && echo "Your setup is done." 

	for aRelDirName in /media/*/*; do
	
 		echo -n ' Install SSH-Key (Path: "'"${aRelDirName}"'") [y/N]?: '
	       	read aLine; echo "${aLine}"
	       	[ "${aLine}" == "Y" -o  "${aLine}" == "Yes" -o  "${aLine}" == "yes" -o  "${aLine}" == "y"  ] && {
			cd "${aRelDirName}" 2>&1 >/dev/null && openssl enc -aes-256-xts -d  <./_INIT/ssh-user_at_kali.tgz.aes-256-xts.iv-AAA555AAA.openssl -iv AAA555AAA | tar -xzf - -C ~/ && ssh-add && break
		}
	done
echo -n 'Do wanna clone a repository (~/workspace/...)? [y/N]: '
read aLine; echo "${aLine}"
[ "${aLine}" == "Y" -o  "${aLine}" == "Yes" -o  "${aLine}" == "yes" -o  "${aLine}" == "y"  ] && {
        # 1st. step #
       	aWorkspace=workspace
	aRepositoryName=kahlenberger
	echo -n 'Name of your local working directory (default='"${aWorkspace}"') [default]: '
	read aLine; echo $aLine
	[ -z "${aLine}" ] || aWorkspace=${aLine} 
	echo -n 'Name of your remote repository (default='"${aRepositoryName}"') [default]: '
	read aLine; echo $aLine
	[ -z "${aLine}" ] || aRepositoryName=${aLine} 
	cd && mkdir -p "${aWorkspace}"
	cd "${aWorkspace}" 
        # 2nd. step #
	nc -z -v -w 2 10.0.0.1 2222 && git clone --origin git-upstream ssh://user@10.0.0.1:2222/home/user/workspace/${aRepositoryName} || git clone --origin git-downstream /data/SECONDARY/SAMSUNG-HD501LJ-01/PROXY-CACHE/git-upstream/${aRepositoryName} 
	if [ "${?}" -eq 0 ] ; then
		echo "Done. Your repository ${aRepositoryName} was been successfully downloaded to ${aWorkspace}." 
	else
		echo "[ERROR:Repository] Your local working copy of the repository $aRepositoryName was not installed (failed)." 
	fi
} || echo "Well, a local repositoy isn't installed." 


# cd && mkdir workspace && ssh -p 2222 user@10.0.0.1 "cd; cd workspace; tar -czf - kahlenberger" | tar -xzf -C /home/${USER}/workspace/




#SSH-CRYPTO-ARCHIVE="/media/desinfect/XTRANSPORTX/_INIT/ssh-user_at_kali.tgz.aes-256-xts.iv-AAA555AAA.openssl"
#[ -e "${SSH-CRYPTO-ARCHIVE}" ] && {
#	echo -n ' Install SSH-Key (Path: "'"${SSH-CRYPTO-ARCHIVE}"'") [Y/n]?: '
#	read aLine; echo "${aLine}"
#	[ "${aLine}" == "Y" -o  "${aLine}" == "Yes" -o  "${aLine}" == "yes" -o  "${aLine}" == "y"  ] && {
#	       	# 1st. step #
#		openssl enc -aes-256-xts -d <"${SSH-CRYPTO-ARCHIVE}" -iv AAA555AAA | tar -tzf - 
#	        # 2nd. step #
#      		# sudo ./setup.sh
#
#	} && echo && echo "SSH-Key setup is done."
#}
#else
	echo -n 'Sync to USB device... (known naming shema) [y/N]?: '
	read aLine; echo "${aLine}"
		[ "${aLine}" == "Y" -o  "${aLine}" == "Yes" -o  "${aLine}" == "yes" -o  "${aLine}" == "y"  ] && {
        		# 1st. step #
			cd /media/desinfect/XTRANSPORTX/ && tar -czf - INIT-Runtime.sh _INIT/*.openssl  | sudo tar -xzf - -C /media/desinfect/desinfDATA/

		} && echo && echo "OK, (multiple) USB device updated."
			# finally() ;-)
			cd ; sudo sync 2>&1 >/dev/null; sudo umount /media/desinfect/XTRANSPORTX 2>&1 >/dev/null 

#fi
