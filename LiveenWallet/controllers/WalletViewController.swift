//
//  WalletViewController.swift
//  LiveenWallet
//
//  Created by 이도현 on 2018. 4. 23..
//  Copyright © 2018년 veenfoundation. All rights reserved.
//

import UIKit

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
        
        self.navigationController?.navigationBar.isHidden = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

