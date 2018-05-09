//
//  CreateWalletViewController.swift
//  LiveenWallet
//
//  Created by 이도현 on 2018. 4. 23..
//  Copyright © 2018년 veenfoundation. All rights reserved.
//

import UIKit
import TextFieldEffects
import KeychainAccess

class CreateWalletViewController: UIViewController {
    @IBOutlet var textFieldLayout:UIStackView!
    var passwordField : HoshiTextField!
    var passwordConfirmField : HoshiTextField!
    
    override func viewWillAppear(_ animated: Bool) {
        passwordField = HoshiTextField()
        passwordField.placeholderColor = .white
        passwordField.borderInactiveColor = .white
        passwordField.borderActiveColor = .white
        passwordField.textColor = .white
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        
        passwordConfirmField = HoshiTextField()
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
    
    //MARK: 패스워드 입력 확인 버튼
    
    
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

    @IBAction func confirmButton(_ sender: Any) {
        
        let password = passwordField.text!
        let confirmPassword = passwordConfirmField.text!
        
        print(password, confirmPassword)

        if password != confirmPassword {
            print("패스워드 불일치")
            let alertController = UIAlertController(title: "Notice", message: "The passwords you typed do not match. Please check the information again.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
            
            return
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
        
        // 계정 생성
        do {
            let veenApi = try VeenAPI()
            if(!veenApi.hasAccount()) {
                let _ = try veenApi.createAccount()
            }
        } catch {
            print("error: \(error)")
            
            let alertController = UIAlertController(title: "Notice", message: error.localizedDescription, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
        
        //패스워드 저장
        savePasswordInKeyChain(passwd: password)
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let walletViewController = mainStoryBoard.instantiateViewController(withIdentifier: "walletViewController") as! WalletViewController
        self.navigationController?.pushViewController(walletViewController, animated: true)
        
    }
}
