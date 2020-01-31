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
        signUpUser(username: username, email: email, password: password)
    }

    func signUpUser(username: String, email: String, password: String) {
        
        AWSMobileClient.default().signUp(username: username,
                                         password: password,
                                         userAttributes: ["email": email]) { (result, error) in

                                            if let error = error {
                                               print("SignIn - \(error)")
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
            showConfirmSignUpMessage()
        case .unconfirmed:
            showUnConfirmSignUpMessage(result: result)
        default:
            print("NA")
        }
    }

    func showUnConfirmSignUpMessage(result: SignUpResult) {
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

                                        DispatchQueue.main.async {
                                            self.navigationController?.popViewController(animated: true)
                                        }

            }
            alert.addAction(action)
            self.present(alert, animated: true)
        }

    }

    func showConfirmSignUpMessage() {

        DispatchQueue.main.async {
            let alert = UIAlertController(title: "User signed up",
                                          message: "Please signin to the app",
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

}
