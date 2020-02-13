# Sample app to test out the different auth flows in AWSMobileClient

## Introduction
Sample app to test different use cases of AWSMobileClient of [AWS iOS SDK](https://aws-amplify.github.io/docs/sdk/ios/authentication). 

## How to use

The sample app is created in such a manner that you can test different auth configuration and setup. When you launch the app you are presented with a viewcontroller to pick the auth flow to use.
When you pick an option from the view controller, the app initializes the AWSMobileClient using the configuration specific for the use case selected. You should not change the selection after this step as mentioned 
[here](https://aws-amplify.github.io/docs/ios/manualsetup#configure-using-an-in-memory-object). If you want to test another auth flow, delete the app content from the simulator.

### Intial setup

1. git clone the project
1. cd to the cloned project
1. Install the pod dependencies `pod install`
1. Open the xcode workspace project
1. Follow the steps from the list below for each use case to create the configuration files.


#### Follow the steps in the links below for different Use cases

1. [Authenticate with username and password using my own UI.](./Documentation/UserPoolCustomUI.md)
This use case covers the following:
* Authentication with username password
* Register a user to user pool
* Uses custom UI for all the task
* Get credentials after authentication
1. [Passwordless authentication](./Documentation/CustomAuthWithUserPool.md)
This use case covers the following:
* Authentication with username and as a second challenge the user enters a verification code. 
* Register a user to user pool
* Uses custom UI for all the task
* Get credentials after authentication
1. [Hosted UI authentication](./Documentation/HostedUI.md)
This use case covers the following:
* You donot need to worry about the UI. User pool provides a webview that will be presented inside your app.
* SignIn with username password
* SignIn with social provider
* Authentication with username password or using social provider will create a user in user pool
* Get credentials after authentication
1. [DropIn UI authentication](./Documentation/DropInUI.md)
This use case covers the following:
* You donot need to worry about the UI. The SDK provide native UI which can be presented inside your app
* SignIn with username password
* SignIn with social provider
* Authentication with username password will create a user in user pool but authenticate with social provider will not create a user
* Get credentials after authentication
