//
//  UserPoolConfirmSignUpViewController.swift
//  AWSMobileClientAuthSample
//
//  Created by Roy, Jithin on 1/27/20.
//  Copyright © 2020 Amazon Web Services. All rights reserved.
//

import UIKit
import AWSMobileClient

protocol ConfirmSignUpDelegate: AnyObject {

    func confirmSignUpCancelled()

    func confirmSignUpSuccess(_ result: SignUpResult)
}

class UserPoolConfirmSignUpViewController: AWSMobileClientBaseViewController {

    @IBOutlet weak var codeTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    public var userName: String!
    weak var delegate: ConfirmSignUpDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameTF.text = userName
    }

    @IBAction func confirmSignUpAction(_ sender: Any) {
        guard let code = codeTF.text else {
            print("Code is empty")
            return
        }
        confirmSignUp(code)
    }

    @IBAction func cancelAction(_ sender: Any) {
        self.delegate?.confirmSignUpCancelled()
    }

    func setDelegate(_ delegate: ConfirmSignUpDelegate) {
        self.delegate = delegate
    }

    func confirmSignUp(_ code: String) {
        guard let userNameFieldValue = usernameTF.text else {
            print("Username is empty")
            return
        }
        AWSMobileClient.default().confirmSignUp(username: userNameFieldValue,
                                                confirmationCode: code) { (result, error) in
                                                    if let error = error {
                                                       print("confirmSignUp - \(error)")
                                                        self.showError(error)
                                                    } else if let result = result {
                                                        self.delegate?.confirmSignUpSuccess(result)
                                                    } else {
                                                        print("Shouldnt happen")
                                                    }
                                                    
        }
    }

    override func showError(_ error: Error) {
        if let awsmobileClientError = error as? AWSMobileClientError {
            switch awsmobileClientError {
            case .codeMismatch (let message):
                showError(message)
            default:
                super.showError(error)
            }
        } else {
            super.showError(error)
        }
    }
}
