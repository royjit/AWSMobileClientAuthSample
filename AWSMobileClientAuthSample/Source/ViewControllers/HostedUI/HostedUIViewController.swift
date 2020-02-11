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
    
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SignIn"
        setupListener()
    }
    
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
                                                guard let result = userState else {
                                                    if let error = error {
                                                        print("SignIn - \(error)")
                                                        self.showError(error)
                                                    }
                                                    return
                                                }
                                                if (result == .signedIn) {
                                                    self.showSignedInMessage()
                                                }
                                                
                                                
        }
    }
    
    func showSignedInMessage() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Successfully signed In",
                                          message: "You have successfully signed in to the app",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",
                                       style: .default) { action in
                                        self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    
    func setupListener() {
        AWSMobileClient.default().addUserStateListener(self) { (state, info) in
            self.updateStatus(state: state)
        }
    }
    
    func updateStatus(state: UserState) {
        DispatchQueue.main.async {
            self.statusLabel.text = "Status: \(state.rawValue)"
        }
    }
    
    override func showError(_ error: Error) {
        if let awsmobileClientError = error as? AWSMobileClientError {
            switch awsmobileClientError {
            case .userNotConfirmed(let message):
                showError(message)
            case .invalidParameter(let message):
                showError(message)
            case .userNotFound(let message):
                showError(message)
            case .invalidState(let message):
                showError(message)
            default:
                super.showError(error)
            }
        } else {
            super.showError(error)
        }
    }
    
}
