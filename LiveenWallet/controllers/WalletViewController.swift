//
//  WalletViewController.swift
//  LiveenWallet
//
//  Created by VeenFoundation on 2018. 4. 23..
//  Copyright © 2018년 veenfoundation. All rights reserved.
//

import UIKit
import KinSDK


class WalletViewController: UIViewController {
    
    @IBOutlet var myVeenLabel:UILabel!
    
    @IBOutlet var sendButton:UIButton!
    @IBOutlet var receiveButton:UIButton!
    
    @IBOutlet var showTransactionButton:UIButton!
    @IBOutlet var changePasswordButton:UIButton!
    @IBOutlet var exportButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showTransactionButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        changePasswordButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        exportButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        showBalance()
        
        self.navigationController?.navigationBar.isHidden = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func showBalance() {
        do {
            let veenApi = try VeenAPI()
            let veen = try veenApi.getCurentVeen()
            myVeenLabel.text = veen.format()
            
            print("my current veen: \(veen.format())")
        } catch {
            print("error in WalletViewController: \(error)")
        }
    }

    @IBAction func sendButtonClick(_ sender: Any) {
        print("sendButtonClick")
        
        let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let sendViewController = mainStoryBoard.instantiateViewController(withIdentifier: "sendViewController") as! SendViewController
        self.navigationController?.pushViewController(sendViewController, animated: true)
    }
    
    @IBAction func reciveButtonClick(_ sender: Any) {
        print("reciveButtonClick")
        
        let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let receiveViewController = mainStoryBoard.instantiateViewController(withIdentifier: "receiveViewController") as! ReceiveViewController
        self.navigationController?.pushViewController(receiveViewController, animated: true)
    }
    
    @IBAction func showTranscationClick(_ sender: Any) {
        print("showTranscationClick")
        
        let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let transactionViewController = mainStoryBoard.instantiateViewController(withIdentifier: "transactionViewController") as! TransactionViewController
        self.navigationController?.pushViewController(transactionViewController, animated: true)
    }
    
    @IBAction func changePasswordClick(_ sender: Any) {
        print("changePassword")
        
        let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let changePasswordViewController = mainStoryBoard.instantiateViewController(withIdentifier: "changePasswordViewController") as! ChangePasswordViewController
        self.navigationController?.pushViewController(changePasswordViewController, animated: true)
    }
    
    @IBAction func exportMyPrivateClick(_ sender: Any) {
        print("exportMyPrivate")
        let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let preExportViewController = mainStoryBoard.instantiateViewController(withIdentifier: "preExportViewController") as! PreExportViewController
        self.navigationController?.pushViewController(preExportViewController, animated: true)
    }
    
}

