//
//  UserPoolSignUpViewController.swift
//  AWSMobileClientAuthSample
//
//  Created by Roy, Jithin on 1/27/20.
//  Copyright © 2020 Amazon Web Services. All rights reserved.
//

import UIKit
import AWSMobileClient

class UserPoolSignUpViewController: AWSMobileClientBaseViewController {

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!

    @IBAction func signUpAction(_ sender: Any) {
        guard let username = userNameTF.text else {
            print("Username is empty")
            return
        }

        guard let email = emailTF.text else {
            print("Email is empty")
            return
        }

        guard let password = passwordTF.text else {
            print("Password is empty")
            return
        }
        signUpUser(username: username,
                   email: email,
                   phoneNumber: phoneNumberTF.text ?? "",
                   password: password)
    }

    @IBAction func alreadyHaveCodeAction(_ sender: Any) {
        presentConfirmSignUpVC()
    }

    func signUpUser(username: String, email: String, phoneNumber: String, password: String) {

        var userAttributes = ["email": email]
        if !phoneNumber.isEmpty {
            userAttributes["phone_number"] = phoneNumber
        }
        AWSMobileClient.default().signUp(username: username,
                                         password: password,
                                         userAttributes: userAttributes) {
                                            (result, error) in

                                            if let error = error {
                                                print("SignUp - \(error)")
                                                self.showError(error)
                                            } else if let result = result {
                                                self.checkSignUpStatus(result: result)
                                            } else {
                                                print("Shouldnt happen")
                                            }

        }
        
    }

    func checkSignUpStatus(result: SignUpResult) {
        switch result.signUpConfirmationState {
        case .confirmed:
            showConfirmedSignUpMessage()
        case .unconfirmed:
            showUnConfirmedSignUpMessage(result: result)
        default:
            print("NA")
        }
    }

    func showUnConfirmedSignUpMessage(result: SignUpResult) {
        DispatchQueue.main.async {
            var message: String = "Please confirm the user"
            if let deliveryDetails = result.codeDeliveryDetails {
                let destination = deliveryDetails.destination ?? ""
                message = "Confirmation code has been send to \(destination)"
            }


            let alert = UIAlertController(title: "Confirm signUp",
                                          message: message,
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",
                                       style: .default) { action in
                                        self.presentConfirmSignUpVC()
            }
            alert.addAction(action)
            self.present(alert, animated: true)
        }

    }

    func showConfirmedSignUpMessage() {

        DispatchQueue.main.async {
            let alert = UIAlertController(title: "User signUp completed",
                                          message: "Please signin to the app to continue.",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",
                                       style: .default) { action in
                                        DispatchQueue.main.async {
                                            self.navigationController?.popViewController(animated: true)
                                        }
            }
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }

    func presentConfirmSignUpVC() {
        if let vc = UIStoryboard.init(name: "Main",
                                      bundle: Bundle.main).instantiateViewController(withIdentifier: "UserPoolConfirmSignUpVCID") as? UserPoolConfirmSignUpViewController {
            vc.userName = self.userNameTF.text ?? ""
            vc.delegate = self
            DispatchQueue.main.async {
                self.present(vc, animated: true)
            }
        }
    }

    override func showError(_ error: Error) {
        if let awsmobileClientError = error as? AWSMobileClientError {
            switch awsmobileClientError {
            case .usernameExists(let message):
                showError(message)
            case .invalidParameter(let message):
                showError(message)
            default:
                super.showError(error)
            }
        } else {
            super.showError(error)
        }
    }

}

extension UserPoolSignUpViewController: ConfirmSignUpDelegate {

    func confirmSignUpCancelled() {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }

    func confirmSignUpSuccess(_ result: SignUpResult) {
        DispatchQueue.main.async {
            self.dismiss(animated: true) {
                self.checkSignUpStatus(result: result)
            }
        }

    }
}

