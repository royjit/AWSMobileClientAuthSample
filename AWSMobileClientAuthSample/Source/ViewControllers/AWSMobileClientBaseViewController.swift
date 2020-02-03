//
//  AWSMobileClientBaseViewController.swift
//  AWSMobileClientAuthSample
//
//  Created by Roy, Jithin on 1/26/20.
//  Copyright © 2020 Amazon Web Services. All rights reserved.
//

import UIKit

class AWSMobileClientBaseViewController: UIViewController {

    func showError(_ error: Error) {

        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error",
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",
                                       style: .default)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }

    func showError(_ message: String) {

        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error",
                                          message: message,
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",
                                       style: .default)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }

}
