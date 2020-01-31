# Sample app to test out the different auth flows in AWSMobileClient

## Introduction
Sample app to test different use cases of AWSMobileClient of [AWS iOS SDK](https://aws-amplify.github.io/docs/sdk/ios/authentication). 

## How to use

The sample app is created in such a manner that you can test different auth configuration and setup. When you launch the app you are presented with a viewcontroller to pick the auth flow to use.
When you pick an option from the view controller, the app initializes the AWSMobileClient using the configuration specific for the use case selected. You should not change the selection after this step as mentioned 
[here](https://aws-amplify.github.io/docs/ios/manualsetup#configure-using-an-in-memory-object). If you want to test another auth flow, delete the app content from the simulator.

### Steps to follow

1. git clone the project
1. cd to the cloned project
1. Install the pod dependencies `pod install`
1. Open the xcode workspace project
1. Follow the steps from the list below for each use case to create the configuration files.


#### Configuration setup for each flow

1. [Username password flow with Custom UI](./Documentation/UserPoolCustomUI.md)