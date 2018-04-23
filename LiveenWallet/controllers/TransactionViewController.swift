//
//  TransactionViewController.swift
//  LiveenWallet
//
//  Created by 이도현 on 2018. 4. 23..
//  Copyright © 2018년 veenfoundation. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController {
    @IBOutlet var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true;
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeView(sender: AnyObject?) {
        self.navigationController?.popViewController(animated: true)
    }
}
