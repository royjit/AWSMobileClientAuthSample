//
//  AuthViewController.swift
//  AWSMobileClientAuthSample
//
//  Created by Roy, Jithin on 1/25/20.
//  Copyright © 2020 Amazon Web Services. All rights reserved.
//

import UIKit
import AWSMobileClient

class AuthViewController: UIViewController {

    public var authType: AuthType!
    @IBOutlet weak var authStatus: UILabel!

    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavigationTitle()
        initializeMobileClient()
        setupListener()
    }

    @IBAction func signInAction(_ sender: Any) {
        var vc: UIViewController?
        switch authType {
        case .userpool:
            vc = UIStoryboard.init(name: "Main",
                                   bundle: Bundle.main).instantiateViewController(withIdentifier: "UserPoolSignInVCID")
        case .dropInUI:
            vc = UIStoryboard.init(name: "Main",
                                   bundle: Bundle.main).instantiateViewController(withIdentifier: "DropInUISignInVCID")
        case .customAuthUserPool:
            vc = UIStoryboard.init(name: "Main",
                                   bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomAuthSignInVCID")
        case .hostedUI:
            vc = UIStoryboard.init(name: "Main",
                                   bundle: Bundle.main).instantiateViewController(withIdentifier: "HostedUISignInVCID")
        default:
            vc = nil
        }

        if let signInVC = vc {
            self.navigationController?.pushViewController(signInVC, animated: true)
        }
        
    }

    @IBAction func signOutAction(_ sender: Any) {
        AWSMobileClient.default().signOut()
    }

    func updateNavigationTitle() {
        switch authType {
        case .userpool:
            self.title = "Userpool with custom UI"
        case .dropInUI:
            self.title = "DropIn UI"
        case .customAuthUserPool:
            self.title = "Custom Auth with custom UI"
        case .hostedUI:
            self.title = "Hosted UI"
        case .none:
            self.title = "Undefined"
        }
    }

    func initializeMobileClient() {
        let configuration = ConfigurationParser.fetchConfiguration(for: authType)
        _ = AWSMobileClient(configuration: configuration)
        AWSMobileClient.default().initialize { (userState, error) in
            if let error = error {
                print ("AWSMobileClient Initialize - \(error)")
            }

            if let state = userState {
                print ("AWSMobileClient Initialize - \(state)")
                self.updateStatus(state: state)
                self.toggleButtons(state == .signedIn)
            }
        }
    }

    func setupListener() {
        AWSMobileClient.default().addUserStateListener(self) { (state, info) in
            self.updateStatus(state: state)
            self.toggleButtons(state == .signedIn)
        }
    }

    func updateStatus(state: UserState) {
        DispatchQueue.main.async {
            self.authStatus.text = "Status: \(state.rawValue)"
        }
    }

    func toggleButtons(_ isSignedIn: Bool) {
        DispatchQueue.main.async {
            self.signInButton.isHidden = isSignedIn
            self.signOutButton.isHidden = !isSignedIn
        }
    }
}

