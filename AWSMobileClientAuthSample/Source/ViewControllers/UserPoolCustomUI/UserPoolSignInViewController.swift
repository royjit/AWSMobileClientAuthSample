//
//  UserPoolSignInViewController.swift
//  AWSMobileClientAuthSample
//
//  Created by Roy, Jithin on 1/25/20.
//  Copyright © 2020 Amazon Web Services. All rights reserved.
//

import UIKit
import AWSMobileClient

class UserPoolSignInViewController: AWSMobileClientBaseViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!

    @IBOutlet weak var confrimSignInTF: UITextField!
    @IBOutlet weak var signUpUsernameTF: UITextField!
    @IBOutlet weak var confirmSignUpTF: UITextField!

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

        guard let password = passwordTF.text else {
            print("Password is empty")
            return
        }

        AWSMobileClient.default().signIn(username: username, password: password) { (result, error) in
            guard let error = error else {
                return
            }
            print("SignIn - \(error)")
            self.showError(error)

        }

    }

    @IBAction func confirmSignInAction(_ sender: Any) {

        guard let response = confrimSignInTF.text else {
            print("Confirm signIn response is empty")
            return
        }

        AWSMobileClient.default().confirmSignIn(challengeResponse: response) { (result, error) in
            guard let error = error else {
                return
            }
            self.showError(error)
        }

    }

    @IBAction func signUpAction(_ sender: Any) {

    }

    @IBAction func confirmSignUp(_ sender: Any) {

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
