//
//  WarningButton.swift
//  AWSMobileClientAuthSample
//
//  Created by Roy, Jithin on 2/3/20.
//  Copyright © 2020 Amazon Web Services. All rights reserved.
//

import UIKit

class WarningButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customizeUI()
    }

    private func customizeUI() {
        if let label = titleLabel {
            label.font = UIFont.boldSystemFont(ofSize: 20)
        }
        layer.cornerRadius = 10
        layer.backgroundColor = #colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1).cgColor
    }
}
