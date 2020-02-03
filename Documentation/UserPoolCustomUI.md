# Username password flow with Custom UI

Username password auth flow is the normal authentication mechanism using username and password. This flow internally uses the 
SRP_A flow of `AWS Cognito userpools` explained [here](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-authentication-flow.html).

The sample app require AWS Cognito configurations for the auth flow to work. The configuration file should be named "userPoolConfiguration.json". You can 
manually add the configuration file or follow the amplify CLI steps(recommended).

### Manual setup of configuration

1. Create an empty file named `userPoolConfiguration.json`.
1. Add the following json into the file
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
                "PoolId": "<Replace ME>",
                "Region": "<Replace ME>"
            }
        }
    },
    "CognitoUserPool": {
        "Default": {
            "PoolId": "<Replace ME>",
            "AppClientId": "<Replace ME>",
            "AppClientSecret": "<Replace ME>",
            "Region": "<Replace ME>"
        }
    },
    "Auth": {
        "Default": {
            "authenticationFlowType": "USER_SRP_AUTH"
        }
    }
}
```

### Use Amplify CLI to create and manage configuration

Instead of addin the configuration manually you can make use of Amplify CLI to create the necessary configuration. 
Follow the steps mentioned [here](https://aws-amplify.github.io/docs/cli-toolchain/quickstart) to initialize the CLI. After that you can
follow any of the steps below to configure auth. Following anyone of the step will create a json file called `awsconfiguration.json`, rename this
file to `userPoolConfiguration.json` for this project.

1. For simple user name password signUp and signIn

```
$ amplify add auth                                                                                   
Using service: Cognito, provided by: awscloudformation

The current configured provider is Amazon Cognito.

Do you want to use the default authentication and security configuration? Default configuration
Warning: you will not be able to edit these selections.
How do you want users to be able to sign in? Username
Do you want to configure advanced settings? No, I am done.

Some next steps:
"amplify push" will build all your local backend resources and provision it in the cloud
"amplify publish" will build all your local backend and frontend resources (if you have hosting category added) and provision it in the cloud

$ amplify push
✔ Successfully pulled backend environment beta from the cloud.

Current Environment: beta

| Category | Resource name           | Operation | Provider plugin   |
| -------- | ----------------------- | --------- | ----------------- |
| Auth     | xxxxxxxxxxx | Create    | awscloudformation |
? Are you sure you want to continue? Yes
 ```


 2. For username password authentication with MFA follow these steps:

```
$ amplify add auth
Using service: Cognito, provided by: awscloudformation

 The current configured provider is Amazon Cognito.

 Do you want to use the default authentication and security configuration? Manual configuration
 Select the authentication/authorization services that you want to use: User Sign-Up, Sign-In, connected with AWS IAM controls (Enables per-user Storage features for images or other content, Analytics, and
more)
 Please provide a friendly name for your resource that will be used to label this category in the project: <projectDemo>
 Please enter a name for your identity pool. <xxxIDP>
 Allow unauthenticated logins? (Provides scoped down permissions that you can control via AWS IAM) No
 Do you want to enable 3rd party authentication providers in your identity pool? No
 Please provide a name for your user pool: <xxxUDP>
 Warning: you will not be able to edit these selections.
 How do you want users to be able to sign in? Username
 Do you want to add User Pool Groups? No
 Do you want to add an admin queries API? No
 Multifactor authentication (MFA) user login options: ON (Required for all logins, can not be enabled later)
 For user login, select the MFA types: SMS Text Message
 Please specify an SMS authentication message: Your authentication code is {####}
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
Successfully added resource <xxx> locally

Some next steps:
"amplify push" will build all your local backend resources and provision it in the cloud
"amplify publish" will build all your local backend and frontend resources (if you have hosting category added) and provision it in the cloud

$ amplify push
✔ Successfully pulled backend environment beta from the cloud.

Current Environment: beta

| Category | Resource name           | Operation | Provider plugin   |
| -------- | ----------------------- | --------- | ----------------- |
| Auth     | xxxxxxxxxxx | Create    | awscloudformation |
? Are you sure you want to continue? Yes
```