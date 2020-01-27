//
//  ViewController.swift
//  AWSMobileClientAuthSample
//
//  Created by Roy, Jithin on 1/24/20.
//  Copyright © 2020 Amazon Web Services. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {


    @IBAction func userPoolSignInAction(_ sender: Any) {
        pushSignInViewController(.userpool)
    }

    @IBAction func dropInUIAction(_ sender: Any) {
        pushSignInViewController(.dropInUI)
    }

    @IBAction func customAuthUserPoolAction(_ sender: Any) {
         pushSignInViewController(.customAuthUserPool)
    }

    func pushSignInViewController(_ authType: AuthType) {
        guard let vc = UIStoryboard.init(name: "Main",
                                         bundle: Bundle.main).instantiateViewController(withIdentifier: "AuthVCID") as? AuthViewController else {
            return
        }
        vc.authType = authType
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

