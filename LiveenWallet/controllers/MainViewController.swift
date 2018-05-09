//
//  MainViewController.swift
//  LiveenWallet
//
//  Created by 이도현 on 2018. 4. 22..
//  Copyright © 2018년 veenfoundation. All rights reserved.
//

import UIKit
import KinSDK

struct Provider: ServiceProvider {
    public let url : URL
    public let networkId: NetworkId
    
    init(url: URL, networkId: NetworkId) {
        self.url = url
        self.networkId = networkId
    }
}

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func createWalletButton(_ sender: Any) {
        print("click Button")
        
        let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let createWalletViewController = mainStoryBoard.instantiateViewController(withIdentifier: "createWalletViewController") as! CreateWalletViewController
        self.navigationController?.pushViewController(createWalletViewController, animated: true)
        
    }
    
}

