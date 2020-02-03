//
//  CustomAuthViewController.swift
//  AWSMobileClientAuthSample
//
//  Created by Roy, Jithin on 2/3/20.
//  Copyright © 2020 Amazon Web Services. All rights reserved.
//

import UIKit
import AWSMobileClient

class CustomAuthViewController: AWSMobileClientBaseViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var userNameTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SignIn"
        setupListener()
    }

    @IBAction func signInAction(_ sender: Any) {
        guard let username = userNameTF.text else {
            print("Username is empty")
            return
        }
        signIn(username: username)
    }

    func signIn(username: String) {
        AWSMobileClient.default().signIn(username: username, password: "dummy") { (result, error) in

            guard let result = result else {
                if let error = error {
                    print("SignIn - \(error)")
                    self.showError(error)
                }
                return
            }
            self.checkSignInStatus(result: result)
        }
    }

    func checkSignInStatus(result: SignInResult) {
        switch result.signInState {
        case .customChallenge:
            self.showVerificationRequiredAlert(result: result)
        case .signedIn:
            self.showSignedInMessage()
        default:
            print("Status = \(result.signInState)")
        }
    }

    func showVerificationRequiredAlert(result: SignInResult) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Custom auth challenge",
                                          message: "Please enter the verification code",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",
                                       style: .default) { action in
                                        self.showCustomAuthConfirmVC()
            }
            alert.addAction(action)
            self.present(alert, animated: true)
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

    func showCustomAuthConfirmVC() {
        DispatchQueue.main.async {
            if let vc = UIStoryboard.init(name: "Main",
                                          bundle: Bundle.main).instantiateViewController(withIdentifier: "UserPoolConfirmSignInVCID") as? UserPoolConfirmSignInViewController {
                vc.setDelegate(self)
                self.present(vc, animated: true)

            }

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

}

extension CustomAuthViewController: ConfirmSignInDelegate {

    func confirmSignInCancelled() {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }

    func confirmSignInSuccess(_ result: SignInResult) {
        DispatchQueue.main.async {
            self.dismiss(animated: true) {
                self.checkSignInStatus(result: result)
            }
        }
    }
}
