# DropIn Authentication UI for iOS 

DropIn authentication UI for iOS provides an authentication UI using the native UI of iOS. You can use dropIn UI to authenticate a user
using UserPools, Facebook or Google. 

Please note that authenticating in DropIn UI with Facebook or Google just federate the identity with Cognito IdentityPool and it doesnot create
a user in Cognito UserPools. If you want to authenticate using social providers like Facebook, Google, Amazon and also wants to create a user
in Cognito UserPools, you have to use [hostedUI](./HostedUI.md).


### Use Amplify CLI to create and manage configuration

Instead of adding the configuration manually you can make use of Amplify CLI to create the necessary configuration. 
Follow the steps mentioned [here](https://aws-amplify.github.io/docs/cli-toolchain/quickstart) to initialize the CLI. After that you can
follow the steps below to configure auth which will create a json file called `awsconfiguration.json`, rename this
file to `hostedUIConfiguration.json` for this project.
Amplify iOS SDK for HostedUI can be found [here](https://aws-amplify.github.io/docs/ios/authentication#drop-in-auth). You have to follow the steps
given under [Federated Identities](https://aws-amplify.github.io/docs/ios/authentication#federated-identities-social-sign-in), to setup each social providers.

```
$ amplify add auth
Using service: Cognito, provided by: awscloudformation

 The current configured provider is Amazon Cognito.

 Do you want to use the default authentication and security configuration? Manual configuration
 Select the authentication/authorization services that you want to use: User Sign-Up, Sign-In, connected with AWS IAM controls (Enables per-user Storage features for images or ot
her content, Analytics, and more)
 Please provide a friendly name for your resource that will be used to label this category in the project: <xxxxx>
 Please enter a name for your identity pool. <xxxxx>
 Allow unauthenticated logins? (Provides scoped down permissions that you can control via AWS IAM) No
 Do you want to enable 3rd party authentication providers in your identity pool? Yes
 Select the third party identity providers you want to configure for your identity pool: Facebook, Google, Amazon

 You've opted to allow users to authenticate via Facebook.  If you haven't already, you'll need to go to https://developers.facebook.com and create an App ID.

 Enter your Facebook App ID for your identity pool:  <xxxxx>

 You've opted to allow users to authenticate via Google.  If you haven't already, you'll need to go to https://developers.google.com/identity and create an App ID.

 Enter your Google Web Client ID for your identity pool:  <xxxxx>

 You've opted to allow users to authenticate via Google within an iOS project.  If you haven't already, you'll need to go to https://developers.google.com/identity and create an
iOS Client ID.

 Enter your Google iOS Client ID for your identity pool:  <xxxxx>

 You've opted to allow users to authenticate via Amazon.  If you haven't already, you'll need to create an Amazon App ID.

 Enter your Amazon App ID for your identity pool:  <xxxxx>
 Please provide a name for your user pool: <xxxxx>
 Warning: you will not be able to edit these selections.
 How do you want users to be able to sign in? Username
 Do you want to add User Pool Groups? No
? Provide a name for your user pool group: Beta
 Do you want to add an admin queries API? No
 Multifactor authentication (MFA) user login options: OFF
 Email based user registration/forgot password: Enabled (Requires per-user email entry at registration)
 Please specify an email verification subject: Your verification code
 Please specify an email verification message: Your verification code is {####}
 Do you want to override the default password policy for this User Pool? No
 Warning: you will not be able to edit these selections.
 What attributes are required for signing up? Email
 Specify the app's refresh token expiration period (in days): 30
 Do you want to specify the user attributes this app can read and write? No
 Do you want to enable any of the following capabilities?
 Do you want to use an OAuth flow? No
? Do you want to configure Lambda Triggers for Cognito? No
Successfully added resource <xxxxx> locally

Some next steps:
"amplify push" will build all your local backend resources and provision it in the cloud
"amplify publish" will build all your local backend and frontend resources (if you have hosting category added) and provision it in the cloud

$ amplify push
✔ Successfully pulled backend environment beta from the cloud.

Current Environment: beta

| Category | Resource name           | Operation | Provider plugin   |
| -------- | ----------------------- | --------- | ----------------- |
| Auth     | <xxxxxxxxxxxxxxxxxxxxx> | Create    | awscloudformation |
? Are you sure you want to continue? Yes
```

After following the CLI the configuration looks like this:

```
{
    "UserAgent": "aws-amplify/cli",
    "Version": "0.1.0",
    "IdentityManager": {
        "Default": {}
    },
    "CredentialsProvider": {
        "CognitoIdentity": {
            "Default": {
                "PoolId": "<xxxx>",
                "Region": "<xxxx>"
            }
        }
    },
    "CognitoUserPool": {
        "Default": {
            "PoolId": "<xxxx>",
            "AppClientId": "<xxxx>",
            "AppClientSecret": "<xxxx>",
            "Region": "<xxxx>"
        }
    },
    "GoogleSignIn": {
        "Permissions": "email,profile,openid",
        "ClientId-WebApp": "<xxxx>",
        "ClientId-iOS": "<xxxx>"
    },
    "FacebookSignIn": {
        "AppId": "<xxxx>",
        "Permissions": "public_profile"
    },
    "Auth": {
        "Default": {
            "authenticationFlowType": "USER_SRP_AUTH"
        }
    }
}
```