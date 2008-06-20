#!/bin/sh
echo $IPHONE_IP
if ping -t 1 -c 1 $IPHONE_IP 
then 
# Placing app files
scp -r $BUILT_PRODUCTS_DIR/$EXECUTABLE_FOLDER_PATH root@$IPHONE_IP:/Applications
# chmod and execute
ssh root@$IPHONE_IP "touch ~/.kill_sb; chmod +x /Applications/$EXECUTABLE_FOLDER_PATH/$EXECUTABLE_NAME"
# Kill SpringBoard if required
ssh root@$IPHONE_IP "if [ -e ~/.kill_sb ]; then rm ~/.kill_sb; killall -9 $EXECUTABLE_NAME; else echo Skip killing SpringBoard; fi"

else echo iPhone not available; fi
