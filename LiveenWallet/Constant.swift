//
//  Constant.swift
//  LiveenWallet
//
//  Created by Techin Park on 2018. 5. 2..
//  Copyright © 2018년 veenfoundation. All rights reserved.
//


import UIKit
import KeychainAccess


class Constant: NSObject {
    
    struct GlobalConstants {
        
        
        // GLOBLE COLOR DEFINE
        
        static let kColor_Seperator: UIColor = UIColor(red: 53.0/255.0, green: 126.0/255.0, blue: 167.0/255.0, alpha: 1.0)
        static let kColor_orange: UIColor = UIColor(red: 255.0/255.0, green: 147.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        static let kColor_NonCompliant: UIColor = UIColor(red: 190.0/255.0, green: 15.0/255.0, blue: 52.0/255.0, alpha: 1.0)
        static let kColor_Compliant: UIColor = UIColor(red: 87.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
        
        // Check Device IPHONE
        
        static let kIphone_4s : Bool =  (UIScreen.main.bounds.size.height == 480)
        static let kIphone_5 : Bool =  (UIScreen.main.bounds.size.height == 568)
        static let kIphone_6 : Bool =  (UIScreen.main.bounds.size.height == 667)
        static let kIphone_6_Plus : Bool =  (UIScreen.main.bounds.size.height == 736)

        // Response searchList
        static let kMainNetURL = "http://veenpf-dns-reg1.southeastasia.cloudapp.azure.com:8545"
        static let kTestNetURL = "https://ropsten.infura.io/0KyDWe43xirRn0m71Q2x"
        static let contractAddress = "0x873cd990852fc6b790abe2cc76c8947610fa6a28"
    }
}
