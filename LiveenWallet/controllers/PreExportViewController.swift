//
//  PreExportViewController.swift
//  LiveenWallet
//
//  Created by 이도현 on 2018. 4. 23..
//  Copyright © 2018년 veenfoundation. All rights reserved.
//

import UIKit
import TextFieldEffects

class PreExportViewController: UIViewController {
    @IBOutlet var passwordFieldArea:UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true;
        
        let passwordField = HoshiTextField()
        passwordField.placeholderColor = .white
        passwordField.borderInactiveColor = .white
        passwordField.borderActiveColor = .white
        passwordField.textColor = .white
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        
        passwordFieldArea.addArrangedSubview(passwordField)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeView(sender: AnyObject?) {
        self.navigationController?.popViewController(animated: true)
    }
}

