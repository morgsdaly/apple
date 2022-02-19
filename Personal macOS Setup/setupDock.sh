#!/bin/bash

# Testing...
# If running with version less than 3.x installed by Homebrew then uncomment this:
# dockutil=/opt/homebrew/bin/dockutil
## else uncomment this one if you installed 3.x direct from - https://github.com/kcrawford/dockutil/releases:
dockutil=/usr/local/bin/dockutil

###########################################################################################
# Original Author: 	     Calum Hunter                                                     #
# Customised by: 		morgsdaly                                                         #
# Date:		     		19/02/2022                                                        #
# Version:	     		1.3                                                               #
# Purpose:       		Dock setup for any new Mac for Morgs.                             #
#                		Configured via Dockutil                                           #
#                		This could be run as a initial login script via LauchAgent        #
###########################################################################################

# /bin/bash/touch /Library/Logs/morgsdaly/dock_setup.log

#---Variables and such---#
script_version="1.3"
user_id=`id -u`
user_name=`id -un $user_id`
home_dir="/Users/$user_name"
dock_setup_done="$home_dir/.docksetupdone"
log_file="/Library/Logs/morgsdaly/dock_setup.log"
os_vers=`sw_vers -productVersion | awk -F "." '{print $2}'`
# target="/tmp/$USER/ServerShares"
readyfile="/Users/Shared/.com.morgsdaly.readyToDefineUserDock"

#---Redirect output to log---#
# exec >> $log_file 2>&1

apple_apps(){
echo `date "+%a %b %d %H:%M:%S"` " - Adding Apple apps to the dock..."
${dockutil} --add '/System/Applications/Mail.app' --no-restart
${dockutil} --add '/System/Applications/Calendar.app' --no-restart
${dockutil} --add '/System/Applications/Messages.app' --no-restart
${dockutil} --add '/System/Applications/Safari.app' --no-restart
${dockutil} --add '/System/Applications/Reminders.app' --no-restart
${dockutil} --add '/System/Applications/Notes.app' --no-restart
}

office365_apps(){
echo `date "+%a %b %d %H:%M:%S"` " - Adding Office 365 apps to the dock..."
${dockutil} --add '/System/Applications/Microsoft Teams.app' --no-restart
${dockutil} --add '/System/Applications/Microsoft To Do.app' --no-restart
${dockutil} --add '/System/Applications/Microsoft Outlook.app' --no-restart
${dockutil} --add '/System/Applications/Microsoft Edge.app' --no-restart
${dockutil} --add '/System/Applications/Microsoft Remote Desktop.app' --no-restart
}

other_apps(){
echo `date "+%a %b %d %H:%M:%S"` " - Adding other apps to the dock..."
${dockutil} --add '/System/Applications/Harvest.app' --no-restart
${dockutil} --add '/System/Applications/PowerShell.app' --no-restart
${dockutil} --add '/System/Applications/Miro.app' --no-restart
${dockutil} --add '/System/Applications/Slack.app' # We restart here before we add folders, its more reliable for some reason

}

initial_dock_setup(){   # Remove the dock items we don't want
echo "*************************************************************************"
echo `date "+%a %b %d %H:%M:%S"` "   - Dock setup beginning v${script_version}"
echo `date "+%a %b %d %H:%M:%S"` "     - User:              $user_name"
echo `date "+%a %b %d %H:%M:%S"` "     - User ID:           $user_id"
echo `date "+%a %b %d %H:%M:%S"` "     - Home Dir:          $home_dir"
echo `date "+%a %b %d %H:%M:%S"` "     - OS Vers:           10.${os_vers}"
echo `date "+%a %b %d %H:%M:%S"` "     - Office Version:    Office $office_vers"
echo `date "+%a %b %d %H:%M:%S"` "     - Adobe CC Version:  Adobe CC $adobe_vers"

echo `date "+%a %b %d %H:%M:%S"` " - Waiting for presence of dock plist"
while [ ! -f ~/Library/Preferences/com.apple.dock.plist ]; do 
    sleep 2     # We sleep 2 seconds here so we don't totally kill the cpu usage
done

sleep 2     # We sleep 3 seconds here so that Apple can set the dock correctly before we modify it

echo `date "+%a %b %d %H:%M:%S"` " - Removing all Dock items"
${dockutil} --remove all
sleep 1

echo `date "+%a %b %d %H:%M:%S"` " - Adding new Dock Items..."
# the dock starts here...
${dockutil} --add '/System/Applications/Launchpad.app' --no-restart
# call the functions above
apple_apps
office365_apps
other_apps
# Did you put your restart on the last app in the last function?

# Add our standard folders, home dir and downloads
# /opt/homebrew/bin/dockutil --add "${target}" --view fan --display stack --position beginning --no-restart # ServerShares folder.
${dockutil} --add "$home_dir/Downloads" --view list --display folder
echo `date "+%a %b %d %H:%M:%S"` " - Dock setup complete!"
echo "*************************************************************************"
touch $dock_setup_done
}

#---Script Actions---#
# First we wait until ~/Documents/GitHub/apple/Personal macOS Setup/setup_my_new_mac produces the readyfile
until [ -a ${readyfile} ] > /dev/null
do
	sleep 2
done

# Don't run for the Admin user
if [ $user_name = "administrator" ]; then
	rm -f "${readyfile}"
    exit 0
fi
if [ ! -f $dock_setup_done ]; then        # Check if the dock setup script has been run before
	initial_dock_setup
	rm -f "${readyfile}"
fi

exit 0