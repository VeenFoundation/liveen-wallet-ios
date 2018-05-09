//
//  ChangePasswordViewController.swift
//  LiveenWallet
//
//  Created by 이도현 on 2018. 4. 23..
//  Copyright © 2018년 veenfoundation. All rights reserved.
//

import UIKit
import TextFieldEffects
import KeychainAccess

class ChangePasswordViewController: UIViewController {
    @IBOutlet var passwordFieldArea:UIStackView!
    
    var passwordField : HoshiTextField!
    var newPasswordField : HoshiTextField!
    var newPasswordConfirmField : HoshiTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true;
        
        passwordField = generatePasswordField()
        passwordField.placeholder = "Existing Password"
        
        newPasswordField = generatePasswordField()
        newPasswordField.placeholder = "New Password"
        
        newPasswordConfirmField = generatePasswordField()
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
    
    @IBAction func confirmButtonClick(_ sender: Any) {
        print("confirm");
        
        let savedPassword = getPasswordInKeyChain()
        let savedTypedPassword = passwordField.text!
        let password = newPasswordField.text!
        let confirmPassword = newPasswordConfirmField.text!
        
        //저장된 패스워드 입력안되있을 경우
        if(savedTypedPassword.count <= 0)
        {
            let alertController = UIAlertController(title: "Notice", message: "The existing passwords typed empty . Please check the information again.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
        
        // 저장된 패스워드와 일치하는지 확인
        if(savedPassword != passwordField.text) {
            let alertController = UIAlertController(title: "Notice", message: "The passwords you typed do not match. Please check the information again.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
        
        // 숫자 + 문자 조합 8자리 이상 체크
        let matched = matches(for:"(?=.*[0-9])(?=.*[a-z]).{8,}", in: password)
        if(!matched) {
            print("패스워드 조건 불충족")
            let alertController = UIAlertController(title: "Notice", message: "The passwords you typed at least, Minimum 8 characters at least 1 Alphabet and 1 Number.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        // 입력한패스워드가 안맞을경우
        if password != confirmPassword {
            print("패스워드 불일치")
            let alertController = UIAlertController(title: "Notice", message: "The passwords you typed do not match. Please check the information again.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        savePasswordInKeyChain(passwd: password)
        
        let alertController = UIAlertController(title: "Notice", message: "Your password has been changed.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: { () in
            self.navigationController?.popViewController(animated: true)
        })
    }

    func matches(for regex: String, in text: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
            return !results.isEmpty
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return false
        }
    }
    
    func savePasswordInKeyChain(passwd password:String) {
        let keychain = Keychain(service: "com.liveen.io.LiveenWallet")
        keychain["appSecret"] =  password
    }

    func getPasswordInKeyChain() -> String {
        let keychain = Keychain(service: "com.liveen.io.LiveenWallet")
        let savedPassword = try? keychain.getString("appSecret")
        return savedPassword as! String
    }
    
    // MARK: IBAction
    @IBAction func closeView(sender: AnyObject?) {
        self.navigationController?.popViewController(animated: true)
    }
}

