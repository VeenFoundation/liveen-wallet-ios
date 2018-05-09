//
//  PreExportViewController.swift
//  LiveenWallet
//
//  Created by 이도현 on 2018. 4. 23..
//  Copyright © 2018년 veenfoundation. All rights reserved.
//

import UIKit
import TextFieldEffects
import KeychainAccess


class PreExportViewController: UIViewController {
    @IBOutlet var passwordFieldArea:UIStackView!
    
    var passwordField : HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true;
        
        passwordField = HoshiTextField()
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
    
    func getPasswordInKeyChain() -> String {
        let keychain = Keychain(service: "com.liveen.io.LiveenWallet")
        let savedPassword = try? keychain.getString("appSecret")
        return savedPassword as! String
    }
    
    
    @IBAction func confirmButtonClick(_ sender: Any) {
    
        print("TEST")
        
        let password = passwordField.text!
        let savedPassword = getPasswordInKeyChain()
        
        print(password, savedPassword)
        
        if(password != savedPassword) {
            
            // 패스워드 불일치
            let alertController = UIAlertController(title: "Notice", message: "The passwords you typed do not match. Please check the password again.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
        else
        {
            // 패스워드 인증 완료시 메인화면으로 넘어갑니다
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let exportViewController = mainStoryBoard.instantiateViewController(withIdentifier: "exportViewController") as! ExportViewController
            self.navigationController?.pushViewController(exportViewController, animated: true)
        }
    }
    
    @IBAction func closeView(sender: AnyObject?) {
        self.navigationController?.popViewController(animated: true)
    }
}

