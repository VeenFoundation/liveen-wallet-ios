//
//  ChangePasswordViewController.swift
//  LiveenWallet
//
//  Created by 이도현 on 2018. 4. 23..
//  Copyright © 2018년 veenfoundation. All rights reserved.
//

import UIKit
import TextFieldEffects

class ChangePasswordViewController: UIViewController {
    @IBOutlet var passwordFieldArea:UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true;
        
        let passwordField = generatePasswordField()
        passwordField.placeholder = "Existing Password"
        
        let newPasswordField = generatePasswordField()
        newPasswordField.placeholder = "New Password"
        
        let newPasswordConfirmField = generatePasswordField()
        newPasswordConfirmField.placeholder = "New Password Confirm"
        
        passwordFieldArea.addArrangedSubview(passwordField)
        passwordFieldArea.addArrangedSubview(newPasswordField)
        passwordFieldArea.addArrangedSubview(newPasswordConfirmField)
    }
    
    func generatePasswordField() -> HoshiTextField {
        let textField = HoshiTextField()
        textField.placeholderColor = .white
        textField.borderInactiveColor = .white
        textField.borderActiveColor = .white
        textField.textColor = .white
        textField.isSecureTextEntry = true
        
        return textField
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeView(sender: AnyObject?) {
        self.navigationController?.popViewController(animated: true)
    }
}

