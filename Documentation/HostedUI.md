# Cognito HostedUI authentication with FB, Google, Apple and Cognito UserPools

Cognito provides a customizable authentication page for signin and signup workflows. Using HostedUI you can create a user in userpools when
the user signin. More details can be found [here](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-app-integration.html).

The sample app require AWS Cognito configurations for the auth flow to work. The configuration file should be named "hostedUIConfiguration.json". Follow the steps given below to prepare the configuration file:

### Use Amplify CLI to create and manage configuration

Instead of adding the configuration manually you can make use of Amplify CLI to create the necessary configuration. 
Follow the steps mentioned [here](https://aws-amplify.github.io/docs/cli-toolchain/quickstart) to initialize the CLI. After that you can
follow any of the steps below to configure auth. Following anyone of the step will create a json file called `awsconfiguration.json`, rename this
file to `hostedUIConfiguration.json` for this project.
Amplify iOS SDK for HostedUI can be found [here](https://aws-amplify.github.io/docs/ios/authentication#using-hosted-ui-for-authentication)
Here is another [sample app](https://github.com/lawmicha/iOS-User-Authentication-with-Email-Facebook-Google-Apple) from @lawmicha.

```
amplify add auth
Using service: Cognito, provided by: awscloudformation

 The current configured provider is Amazon Cognito.

 Do you want to use the default authentication and security configuration? Default configuration with Social Provider (Federation)
 Warning: you will not be able to edit these selections.
 How do you want users to be able to sign in? Username
 Do you want to configure advanced settings? No, I am done.
 What domain name prefix you want us to create for you? <xxxx>
 Enter your redirect signin URI: <xxxx>
? Do you want to add another redirect signin URI No
 Enter your redirect signout URI: <xxxx>
? Do you want to add another redirect signout URI No
 Select the social providers you want to configure for your user pool: Facebook, Google, Login With Amazon

 You've opted to allow users to authenticate via Facebook.  If you haven't already, you'll need to go to https://developers.facebook.com and create an App ID.

 Enter your Facebook App ID for your OAuth flow:  <xxxx>
 Enter your Facebook App Secret for your OAuth flow:  <xxxx>

 You've opted to allow users to authenticate via Google.  If you haven't already, you'll need to go to https://developers.google.com/identity and create an App ID.

 Enter your Google Web Client ID for your OAuth flow:  <xxxx>
 Enter your Google Web Client Secret for your OAuth flow:  <xxxx>

 You've opted to allow users to authenticate via Amazon.  If you haven't already, you'll need to create an Amazon App ID.

 Enter your Amazon App ID for your OAuth flow:  <xxxx>
 Enter your Amazon App Secret for your OAuth flow:  <xxxx>
Successfully added resource <xxxx> locally

Some next steps:
"amplify push" will build all your local backend resources and provision it in the cloud
"amplify publish" will build all your local backend and frontend resources (if you have hosting category added) and provision it in the cloud

 $ amplify push
✔ Successfully pulled backend environment beta from the cloud.

Current Environment: beta

| Category | Resource name   | Operation | Provider plugin   |
| -------- | --------------- | --------- | ----------------- |
| Auth     | <xxxxxxxxxxxxx> | Create    | awscloudformation |
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
                "PoolId": "xxxx",
                "Region": "xxxx"
            }
        }
    },
    "CognitoUserPool": {
        "Default": {
            "PoolId": "xxxx",
            "AppClientId": "xxxx",
            "AppClientSecret": "xxxx",
            "Region": "us-east-1"
        }
    },
    "Auth": {
        "Default": {
            "OAuth": {
                "WebDomain": "xxxx",
                "AppClientId": "xxxx",
                "AppClientSecret": "xxxx",
                "SignInRedirectURI": "xxxx",
                "SignOutRedirectURI": "xxxx",
                "Scopes": [
                    "phone",
                    "email",
                    "openid",
                    "profile",
                    "aws.cognito.signin.user.admin"
                ]
            },
            "authenticationFlowType": "USER_SRP_AUTH"
        }
    }
}
```