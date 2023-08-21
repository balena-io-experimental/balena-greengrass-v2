#!/bin/bash

sleep 4

FILE=/user-data/installed.txt

if [ -f "$FILE" ]; then
    echo "Device is already provisioned."
else 
    echo "Device is not provisioned... starting provisioning steps."
    # check for required env var values
    requirements=True
    if [[ -z $AWS_REGION ]]; then
        echo "You must set AWS_REGION before this device can be provisioned!"
        requirements=False
    else
        echo "Found AWS_REGION value $AWS_REGION."
    fi
    
    if [[ -z $AWS_ACCESS_KEY_ID ]]; then
        echo "You must set AWS_ACCESS_KEY_ID before this device can be provisioned!"
        requirements=False
    else
        echo "Found AWS_ACCESS_KEY_ID value."
    fi
 
    if [[ -z $AWS_SECRET_ACCESS_KEY ]]; then
        echo "You must set AWS_SECRET_ACCESS_KEY before this device can be provisioned!"
        requirements=False
    else
        echo "Found AWS_SECRET_ACCESS_KEY value."
    fi

    if [[ -z $GG_THING_NAME ]]; then
        echo "You must set GG_THING_NAME before this device can be provisioned!"
        requirements=False
    else
        echo "Found GG_THING_NAME value $GG_THING_NAME."
    fi
    
    # if not provisioned, and required env vars available, run the installer

    # (starting in /usr/src)

    if [ $requirements == "True" ]
    then
        echo "STARTING INSTALL..."
    
        if [[ -z $GG_GROUP_NAME ]]; then
            echo "No GG_GROUP_NAME provided; not adding thing to an existing group."
            java -Droot="/greengrass/v2" -Dlog.store=FILE -jar ./GreengrassInstaller/lib/Greengrass.jar --aws-region "$AWS_REGION" --thing-name "$GG_THING_NAME" --component-default-user ggc_user:ggc_group --provision true --setup-system-service false --deploy-dev-tools true
        else
            echo "Found GG_GROUP_NAME value; adding thing to $GG_GROUP_NAME group."
            java -Droot="/greengrass/v2" -Dlog.store=FILE -jar ./GreengrassInstaller/lib/Greengrass.jar --aws-region "$AWS_REGION" --thing-name "$GG_THING_NAME" --thing-group-name "$GG_GROUP_NAME" --component-default-user ggc_user:ggc_group --provision true --setup-system-service false --deploy-dev-tools true
        fi
        
        # Set flag to let us know this was provisioned
        touch "$FILE"
    
    else
        echo "NOT installing software - requirements not met - see above..."
        
    fi        

fi

# Start AWS IoT Core Software and nucleus

if [ -f "$FILE" ]; then
    echo "STARTING AWS IoT Core and Nucleus."

    /bin/sh /greengrass/v2/alts/current/distro/bin/loader
else
    echo "Software is not installed..."
fi




