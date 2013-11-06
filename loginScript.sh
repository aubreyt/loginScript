#!/bin/bash
#################################################################################
#										#
# Date: Nov 5, 2013								#	 
# Author: Aubrey Thomson	 						#
#										#
#################################################################################
 
## Set the $userName variable
userName=$(/usr/bin/id -P | awk -F: '{ print $1 }') #Active Directory username
userMount=$userName"_mount"                         #User's share mount point created by adding "_mount" to username
userShare=$userName"$"                              #User's share on the file server
fileSrv=fileserver.domain.local                     #File server FQDN

## Map user's file server share
     if [ $userName != "admin" ]
     then
        if [ $userName != "root" ]
          then
          	if [ ! -d /Users/$userName/Desktop/$userMount ];
          	  then
            	mkdir /Users/$userName/Desktop/$userMount
            fi
            mount -t smbfs //$userName@$fileSrv/$userShare /Users/$userName/Desktop/$userMount

## Map Commercial share
      if [ "`dsmemberutil checkmembership -U $userName -G 'Commercial Modify'`" == "user is a member of the group" ]
      then
      if [ ! -d /Users/$userName/Desktop/'Clients - Commercial' ];
          	  then
            	mkdir /Users/$userName/Desktop/'Clients - Commercial'
            fi
	mount -t smbfs //$userName@$fileSrv/Clients_Commercial /Users/$userName/Desktop/"Clients - Commercial"
    fi

## Map Government share
     if [ "`dsmemberutil checkmembership -U $userName -G 'Commercial Modify'`" == "user is a member of the group" ]
      then
      if [ ! -d /Users/$userName/Desktop/'Clients - Government' ];
          	  then
            	mkdir /Users/$userName/Desktop/'Clients - Government'
            fi
        mount -t smbfs //$userName@$fileSrv/Clients_Government /Users/$userName/Desktop/"Clients - Government"
    fi

## Map Marketing share
     if [ "`dsmemberutil checkmembership -U $userName -G 'Marketing Modify'`" == "user is a member of the group" ]
      then
      if [ ! -d /Users/$userName/Desktop/'Marketing' ];
          	  then
            	mkdir /Users/$userName/Desktop/'Marketing'
            fi
        mount -t smbfs //$userName@$fileSrv/Marketing /Users/$userName/Desktop/"Marketing"
    fi

## Map Library share
     if [ "`dsmemberutil checkmembership -U $userName -G 'Library Modify'`" == "user is a member of the group" ]
      then
      if [ ! -d /Users/$userName/Desktop/'Library' ];
          	  then
            	mkdir /Users/$userName/Desktop/'Library'
            fi
        mount -t smbfs //$userName@$fileSrv/Library /Users/$userName/Desktop/"Library"
    fi

## Map IT share
     if [ "`dsmemberutil checkmembership -U $userName -G 'IT'`" == "user is a member of the group" ]
      then
      if [ ! -d /Users/$userName/Desktop/'IT' ];
          	  then
            	mkdir /Users/$userName/Desktop/'IT'
            fi
        mount -t smbfs //$userName@$fileSrv/it$ /Users/$userName/Desktop/"IT"
    fi
    
## Map HR share
     if [ "`dsmemberutil checkmembership -U $userName -G 'HR'`" == "user is a member of the group" ]
      then
      if [ ! -d /Users/$userName/Desktop/'HR' ];
          	  then
            	mkdir /Users/$userName/Desktop/'HR'
            fi
        mount -t smbfs //$userName@$fileSrv/hr$ /Users/$userName/Desktop/"HR"
    fi
fi
fi

osascript -e 'tell application "System Events" to set require password to wake of security preferences to true'

killall Terminal
