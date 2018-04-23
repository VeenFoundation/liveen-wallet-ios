//
//  CreateWalletViewController.swift
//  LiveenWallet
//
//  Created by 이도현 on 2018. 4. 23..
//  Copyright © 2018년 veenfoundation. All rights reserved.
//

import UIKit
import TextFieldEffects

class CreateWalletViewController: UIViewController {
    @IBOutlet var textFieldLayout:UIStackView!
    
    override func viewWillAppear(_ animated: Bool) {
        let passwordField = HoshiTextField()
        passwordField.placeholderColor = .white
        passwordField.borderInactiveColor = .white
        passwordField.borderActiveColor = .white
        passwordField.textColor = .white
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        
        let passwordConfirmField = HoshiTextField()
        passwordConfirmField.placeholderColor = .white
        passwordConfirmField.borderInactiveColor = .white
        passwordConfirmField.borderActiveColor = .white
        passwordConfirmField.textColor = .white
        passwordConfirmField.placeholder = "PasswordConfirm"
        passwordConfirmField.isSecureTextEntry = true
        
        textFieldLayout.addArrangedSubview(passwordField)
        textFieldLayout.addArrangedSubview(passwordConfirmField)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
