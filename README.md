# balena-greengrass-v2
Create an "AWS IoT Thing" (a Greengrass core device) that runs on balenaOS. 

## Getting started

You'll need an AWS account and an AWS Identity and Access Management (IAM) user with administrator permissions (See [this section](https://docs.aws.amazon.com/greengrass/v2/developerguide/getting-started-prerequisites.html) for more details. 

You'll also need a balena account (the first 10 devices are free and full-featured) by signing up [here](https://dashboard.balena-cloud.com/signup).

Then, follow these steps:

1. Create a new fleet in your balenaCloud dashboard, and add a new device to the fleet.

2. Set the following [device variables](https://docs.balena.io/learn/manage/variables/) for your AWS IoT Thing in the balenaCloud dashboard (do this before pushing any code to your fleet!):

- `AWS_REGION` such as `us-east-1` or whichever is used for your devices (usually seen in the upper right of your AWS dashboard)

- `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` from an authorized AWS user on your account. See "Security Credentials" under your username to generate access keys.

- `GG_THING_NAME` should be set to the name you want to give your AWS IoT Thing.

- `GG_GROUP_NAME` is optional... don't assign any value to this variable to deploy your core device without assigning a AWS IoT thing group. Otherwise, enter a new or existing group name.

3. Clone this repo to your development computer, and use the [balena CLI](https://docs.balena.io/reference/balena-cli/) to push this code to your balena fleet.

## Setup

Once you have pushed this code to your device, it will use the variables you have assigned above to:

- Install Java (Corretto 11) on the device

- Download and run the AWS IoT Greengrass installer on the device (in a container) that provisions the Greengrass core device as an AWS IoT thing with a device certificate and default permissions.

When the installer completes, you can find your device in the list of Greengrass core devices on the AWS Core devices page. You can then use the AWS IoT Greengrass consoleto deploy a component (such as a Lambda function) to the target device.
