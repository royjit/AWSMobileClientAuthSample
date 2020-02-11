//
//  DropInUIViewController.swift
//  AWSMobileClientAuthSample
//
//  Created by Roy, Jithin on 1/26/20.
//  Copyright © 2020 Amazon Web Services. All rights reserved.
//

import UIKit
import AWSMobileClient

class DropInUIViewController: AWSMobileClientBaseViewController {
    
    @IBOutlet weak var statusLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SignIn"
        setupListener()
    }
    
    @IBAction func signInAction(_ sender: Any) {
        
        let signInOptions = SignInUIOptions(canCancel: true)
        AWSMobileClient.default().showSignIn(navigationController: self.navigationController!,
                                             signInUIOptions: signInOptions,
                                             { (userState, error) in
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
        })
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
    
    func updateStatus(state: UserState) {
        DispatchQueue.main.async {
            self.statusLabel.text = "Status: \(state.rawValue)"
        }
    }
    
    func setupListener() {
        AWSMobileClient.default().addUserStateListener(self) { (state, info) in
            self.updateStatus(state: state)
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
