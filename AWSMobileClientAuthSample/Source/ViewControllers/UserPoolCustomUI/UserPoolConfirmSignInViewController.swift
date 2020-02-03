//
//  UserPoolConfirmSignInViewController.swift
//  AWSMobileClientAuthSample
//
//  Created by Roy, Jithin on 1/27/20.
//  Copyright © 2020 Amazon Web Services. All rights reserved.
//

import UIKit
import AWSMobileClient

protocol ConfirmSignInDelegate: AnyObject {

    func confirmSignInCancelled()

    func confirmSignInSuccess(_ result: SignInResult)
}

class UserPoolConfirmSignInViewController: AWSMobileClientBaseViewController {

    @IBOutlet weak var confrimSignInTF: UITextField!

    weak var delegate: ConfirmSignInDelegate?

    @IBAction func confirmSignInAction(_ sender: Any) {

        guard let response = confrimSignInTF.text else {
            print("Confirm signIn response is empty")
            return
        }
        confirmSignIn(response)
    }

    @IBAction func cancelAction(_ sender: Any) {
        self.delegate?.confirmSignInCancelled()
    }

    func setDelegate(_ delegate: ConfirmSignInDelegate) {
        self.delegate = delegate
    }

    func confirmSignIn(_ code: String) {
        AWSMobileClient.default().confirmSignIn(challengeResponse: code) { (result, error) in
            guard let result = result else {
                if let error = error {
                    print("confirmSignIn - \(error)")
                    self.showError(error)
                }
                return
            }
            self.delegate?.confirmSignInSuccess(result)
        }
    }

}
