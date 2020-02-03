//
//  HostedUIViewController.swift
//  AWSMobileClientAuthSample
//
//  Created by Roy, Jithin on 1/31/20.
//  Copyright © 2020 Amazon Web Services. All rights reserved.
//

import UIKit
import AWSMobileClient

class HostedUIViewController: AWSMobileClientBaseViewController {

    
    @IBAction func signInUserPoolsAction(_ sender: Any) {
        handleFederatedSignIn()
    }

    @IBAction func signInFBAction(_ sender: Any) {
        handleFederatedSignIn(identityProvider: "Facebook")
    }

    @IBAction func signInGoogleAction(_ sender: Any) {
        handleFederatedSignIn(identityProvider: "Google")
    }
    @IBAction func signInAppleAction(_ sender: Any) {
        handleFederatedSignIn(identityProvider: "SignInWithApple")
    }

    func handleFederatedSignIn(identityProvider: String? = nil) {

        var hostedUIOptions: HostedUIOptions? = nil
        if let provider = identityProvider {
            hostedUIOptions = HostedUIOptions(scopes: ["openid", "email"],
                                              identityProvider: provider)
        } else {
            hostedUIOptions = HostedUIOptions(scopes: ["openid", "email"])
        }

        // Present the Hosted UI sign in.
        AWSMobileClient.default().showSignIn(navigationController: self.navigationController!,
                                             hostedUIOptions: hostedUIOptions) { (userState, error) in
            if let error = error as? AWSMobileClientError {
                print("Error ShowSignIn: ", error)

                DispatchQueue.main.async {
                    //self.errorMessageLabel.text = "Error ShowSignIn: \(error.message)"
                }

                return
            }

        }
    }

}
