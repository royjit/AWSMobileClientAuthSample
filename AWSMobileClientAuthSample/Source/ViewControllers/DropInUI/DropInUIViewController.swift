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
                                                guard let error = error else {
                                                    return
                                                }
                                                print("SignIn - \(error)")
                                                self.showError(error)
        })
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
