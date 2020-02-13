//
//  NormalButton.swift
//  AWSMobileClientAuthSample
//
//  Created by Roy, Jithin on 2/3/20.
//  Copyright © 2020 Amazon Web Services. All rights reserved.
//

import UIKit

class NormalButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customizeUI()
    }

    private func customizeUI() {
        layer.cornerRadius = 10
        layer.backgroundColor = #colorLiteral(red: 0.1209238527, green: 0.6587851668, blue: 1, alpha: 1).cgColor
    }
}
