# Cognito HostedUI authentication with FB, Google, Apple and Cognito UserPools

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
