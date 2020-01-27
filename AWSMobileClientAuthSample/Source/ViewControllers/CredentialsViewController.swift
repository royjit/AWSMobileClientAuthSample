//
//  CredentialsViewController.swift
//  AWSMobileClientAuthSample
//
//  Created by Roy, Jithin on 1/25/20.
//  Copyright © 2020 Amazon Web Services. All rights reserved.
//

import UIKit
import AWSMobileClient

class CredentialsViewController: UIViewController {

    @IBOutlet weak var identityIdLabel: UILabel!
    @IBOutlet weak var identityIdErrorLabel: UILabel!

    @IBOutlet weak var tokenLabel: UILabel!
    @IBOutlet weak var tokenErrorLabel: UILabel!

    @IBOutlet weak var accessTokenLabel: UILabel!
    @IBOutlet weak var accessTokenErrorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Token/Credentials"
    }

    @IBAction func fetchIdAction(_ sender: Any) {
        fetchID()
    }

    @IBAction func fetchTokenAction(_ sender: Any) {
        fetchToken()
    }

    @IBAction func fetchCredentialsAction(_ sender: Any) {
        fetchCredentials()

    }

    @IBAction func fetchAllAction(_ sender: Any) {
        fetchID()
        fetchToken()
        fetchCredentials()
    }

    private func fetchID() {
        AWSMobileClient.default().getIdentityId().continueWith { (task) -> Any? in
            if let error = task.error {
                print("getIdentityId - \(error)")
                DispatchQueue.main.async {
                    self.identityIdErrorLabel.text = error.localizedDescription
                }
            }

            if let result = task.result {
                DispatchQueue.main.async {
                    self.identityIdLabel.text = result as String
                    self.identityIdErrorLabel.text = ""
                }
            }
            return nil
        }
    }

    private func fetchToken() {

        AWSMobileClient.default().getTokens { (token, error) in
            if let error = error {
                print("getTokens - \(error)")
                DispatchQueue.main.async {
                    self.tokenErrorLabel.text = error.localizedDescription
                }
            }

            if let result = token {
                DispatchQueue.main.async {
                    self.tokenLabel.text = result.idToken?.tokenString
                    self.tokenErrorLabel.text = ""
                }
            }
        }

    }

    private func fetchCredentials() {
        AWSMobileClient.default().getAWSCredentials { (credentials, error) in
            if let error = error {
                print("getAWSCredentials - \(error)")
                DispatchQueue.main.async {
                    self.accessTokenErrorLabel.text = error.localizedDescription
                }
            }

            if let result = credentials {
                DispatchQueue.main.async {
                    self.accessTokenLabel.text = result.accessKey
                    self.accessTokenErrorLabel.text = ""
                }
            }
        }
    }

}
