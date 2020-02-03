# Authenticate with passwordless flow (Custom authentication in Cognito UserPools)

Passwordless authentication flow is a two step auth flow where in the first step the user enter a username and call signIn. The service response
back with a challenge. This challenge can be a captcha challenge, OTP etc.. which is custom defined by the developer. On verifying the challenge successfully
the user is authenticated. For this sample app the challenge is same and hard coded. Details of custom auth in cognito can be found [here](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-authentication-flow.html).

The sample app require AWS Cognito configurations for the auth flow to work. The configuration file should be named "customAuthUserPoolConfiguration.json". You can 
manually add the configuration file or follow the amplify CLI steps(recommended).

### Manual setup of configuration

1. Create an empty file named `customAuthUserPoolConfiguration.json`.
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
                "PoolId": "<xxxxx>",
                "Region": "<xxxxx>"
            }
        }
    },
    "CognitoUserPool": {
        "Default": {
            "PoolId": "<xxxxx>",
            "AppClientId": "<xxxxx>",
            "AppClientSecret": "<xxxxx>",
            "Region": "<xxxxx>"
        }
    },
    "Auth": {
        "Default": {
            "authenticationFlowType": "CUSTOM_AUTH"
        }
    }
}
```

### Use Amplify CLI to create and manage configuration

Instead of adding the configuration manually you can make use of Amplify CLI to create the necessary configuration. 
Follow the steps mentioned [here](https://aws-amplify.github.io/docs/cli-toolchain/quickstart) to initialize the CLI. After that you can
follow any of the steps below to configure auth. Following anyone of the step will create a json file called `awsconfiguration.json`, rename this
file to `customAuthUserPoolConfiguration.json` for this project.

```
$ amplify add auth
Using service: Cognito, provided by: awscloudformation

 The current configured provider is Amazon Cognito.

 Do you want to use the default authentication and security configuration? (Use arrow keys)
❯ Default configuration
  Default configuration with Social Provider (Federation)
  Manual configuration

 The current configured provider is Amazon Cognito.

 Do you want to use the default authentication and security configuration? Manual configuration
 Select the authentication/authorization services that you want to use: User Sign-Up, Sign-In, connected with AWS IAM controls (Enables per-user Storage features for images or
other content, Analytics, and more)
 Please provide a friendly name for your resource that will be used to label this category in the project: <xxxxxxxx>
 Please enter a name for your identity pool. <xxxxxxxx>
 Allow unauthenticated logins? (Provides scoped down permissions that you can control via AWS IAM) No
 Do you want to enable 3rd party authentication providers in your identity pool? No
 Please provide a name for your user pool: <xxxxxxxx>
 Warning: you will not be able to edit these selections.
 How do you want users to be able to sign in? Username
 Do you want to add User Pool Groups? No
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
? Do you want to configure Lambda Triggers for Cognito? Yes
? Which triggers do you want to enable for Cognito Create Auth Challenge, Define Auth Challenge, Verify Auth Challenge Response
? What functionality do you want to use for Create Auth Challenge Custom Auth Challenge Scaffolding (Creation)
? What functionality do you want to use for Define Auth Challenge Custom Auth Challenge Scaffolding (Definition)
? What functionality do you want to use for Verify Auth Challenge Response Custom Auth Challenge Scaffolding (Verification)
? Enter the answer to your custom auth challenge 1010
Succesfully added the Lambda function locally
? Do you want to edit your boilerplate-create-challenge function now? Yes
Please edit the file in your editor: <xxxxxxxx>
? Press enter to continue
Succesfully added the Lambda function locally
? Do you want to edit your boilerplate-define-challenge function now? Yes
Please edit the file in your editor: <xxxxxxxx>
? Press enter to continue
Succesfully added the Lambda function locally
? Do you want to edit your boilerplate-verify function now? Yes
Please edit the file in your editor: <xxxxxxxx>
? Press enter to continue
Successfully added resource <xxxxxxxxxxxxxxxxxxxxx> locally

Some next steps:
"amplify push" will build all your local backend resources and provision it in the cloud
"amplify publish" will build all your local backend and frontend resources (if you have hosting category added) and provision it in the cloud

$ amplify push
✔ Successfully pulled backend environment beta from the cloud.

Current Environment: beta

| Category | Resource name                                      | Operation | Provider plugin   |
| -------- | -------------------------------------------------- | --------- | ----------------- |
| Auth     | <xxxxxxxxxxxxxxxxxxxxx>                            | Create    | awscloudformation |
| Function | <xxxxxxxxxxxxxxxxxxxxx>CreateAuthChallenge         | Create    | awscloudformation |
| Function | <xxxxxxxxxxxxxxxxxxxxx>DefineAuthChallenge         | Create    | awscloudformation |
| Function | <xxxxxxxxxxxxxxxxxxxxx>VerifyAuthChallengeResponse | Create    | awscloudformation |
? Are you sure you want to continue? Yes

```
The sample app uses the following lambda functions. Please note that the first step of iOS AWSMobileClient require SRP_A as mentioned [here](https://aws-amplify.github.io/docs/sdk/ios/authentication#lambda-trigger-setup).

Define Auth Challenge

```
exports.handler = function(event, context) {
if (event.request.session.length == 1 && event.request.session[0].challengeName == 'SRP_A') {
    event.response.issueTokens = false;
    event.response.failAuthentication = false;
    event.response.challengeName = 'CUSTOM_CHALLENGE';
} else if (event.request.session.length == 2 && event.request.session[1].challengeName == 'CUSTOM_CHALLENGE' && event.request.session[1].challengeResult == true) {
    event.response.issueTokens = true;
    event.response.failAuthentication = false;
    event.response.challengeName = 'CUSTOM_CHALLENGE';
} else {
    event.response.issueTokens = false;
    event.response.failAuthentication = true;
}
    context.done(null, event);
}
```
Verify Auth Challenge Response
```
function verifyAuthChallengeResponse(event) {
    if (event.request.privateChallengeParameters.answer === event.request.challengeAnswer) {
        event.response.answerCorrect = true;
    } else {
        event.response.answerCorrect = false;
    }
}

exports.handler = (event, context, callback) => {
    verifyAuthChallengeResponse(event);
    callback(null, event);
};
```
Create Auth Challenge
```
function createAuthChallenge(event) {
    if (event.request.challengeName === 'CUSTOM_CHALLENGE') {
        event.response.publicChallengeParameters = {};
        event.response.privateChallengeParameters = {};
        event.response.privateChallengeParameters.answer = process.env.CHALLENGEANSWER;
    }
}

exports.handler = (event, context, callback) => {
    createAuthChallenge(event);
    callback(null, event);
};
```