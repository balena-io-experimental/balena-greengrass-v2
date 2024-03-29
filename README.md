# balena-greengrass-v2
Create an "AWS IoT Thing" (a Greengrass core device) that runs on balenaOS. 

## Getting started

You'll need an AWS account and an AWS Identity and Access Management (IAM) user with administrator permissions (See [this section](https://docs.aws.amazon.com/greengrass/v2/developerguide/getting-started-prerequisites.html) for more details.)

You'll also need a balena account (the first 10 devices are free and full-featured) by signing up [here](https://dashboard.balena-cloud.com/signup).

Then, follow these steps:

1. Click Deploy with balena and create a new fleet in your balenaCloud dashboard. Then add a new device to the fleet.

[![](https://www.balena.io/deploy.png)](https://dashboard.balena-cloud.com/deploy?repoUrl=https://github.com/balena-io-experimental/balena-greengrass-v2)

2. Once the device is online, set the following [device variables](https://docs.balena.io/learn/manage/variables/) for your AWS IoT Thing in the balenaCloud dashboard:

- `AWS_REGION` such as `us-east-1` or whichever is used for your devices (usually seen in the upper right of your AWS dashboard)

- `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` from an authorized AWS user on your account. See "Security Credentials" under your username to generate access keys. 

- `GG_THING_NAME` should be set to the name you want to give your AWS IoT Thing.

- `GG_GROUP_NAME` is optional... don't assign any value to this variable to deploy your core device without assigning a AWS IoT thing group. Otherwise, enter a new or existing group name.

Note that these variables are only used for provisioning and can be deleted once the device appears in your Greengrass console. At the least, you should delete your access keys for enhanced security.

3. Clone this repo to your development computer, and use the [balena CLI](https://docs.balena.io/reference/balena-cli/) to push this code to your balena fleet.

## Setup

Once you have pushed this code to your device, it will use the variables you have assigned above to:

- Install Java (Corretto 11) on the device

- Download and run the AWS IoT Greengrass installer on the device (in a container) that provisions the Greengrass core device as an AWS IoT thing with a device certificate and default permissions.


When the installer completes, you can find your device in the list of Greengrass core devices on the AWS Core devices page. You can then use the AWS IoT Greengrass console to deploy a component (such as a Lambda function) to the target device.

The `/greengrass` folder is on a persistent volume so that reboots and container restarts will not require Greengrass re-provisioning the device. To force the device to re-provision with Greengrass, delete the `/user-data/installed.txt` file and reboot or restart the greengrass container.
