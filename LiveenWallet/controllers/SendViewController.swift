//
//  SendViewController.swift
//  LiveenWallet
//
//  Created by 이도현 on 2018. 4. 23..
//  Copyright © 2018년 veenfoundation. All rights reserved.
//

import UIKit
import TextFieldEffects

class SendViewController: UIViewController {
    @IBOutlet var inputArea:UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hid navigation bar
        self.navigationController?.navigationBar.isHidden = true;
        
        displayInputFields()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func displayInputFields() {
        let amountField = HoshiTextField()
        amountField.placeholderColor = .white
        amountField.borderInactiveColor = .white
        amountField.borderActiveColor = .white
        amountField.textColor = .white
        amountField.placeholder = "Amount"
        amountField.keyboardType = .numberPad
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let addressField = HoshiTextField()
        addressField.placeholderColor = .white
        addressField.borderInactiveColor = .white
        addressField.borderActiveColor = .white
        addressField.textColor = .white
        addressField.placeholder = "To Address"
        addressField.invalidateIntrinsicContentSize()
        
        let button = UIButton()
        button.setImage(UIImage(named: "ic_qrcode"), for: .normal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        stackView.addArrangedSubview(addressField)
        stackView.addArrangedSubview(button)
        
        let passwordField = HoshiTextField()
        passwordField.placeholderColor = .white
        passwordField.borderInactiveColor = .white
        passwordField.borderActiveColor = .white
        passwordField.textColor = .white
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        
        inputArea.addArrangedSubview(amountField)
        inputArea.addArrangedSubview(stackView)
        inputArea.addArrangedSubview(passwordField)
    }
    
    @IBAction func closeView(sender: AnyObject?) {
        self.navigationController?.popViewController(animated: true)
    }
}
