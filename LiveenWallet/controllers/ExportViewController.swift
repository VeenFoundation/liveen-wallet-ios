//
//  ExportViewController.swift
//  LiveenWallet
//
//  Created by 이도현 on 2018. 4. 23..
//  Copyright © 2018년 veenfoundation. All rights reserved.
//

import UIKit

class ExportViewController: UIViewController {
    @IBOutlet var qrcodeImageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true;
        
        // export with passphase.
        do {
            let veenApi = try VeenAPI()
            let key = try veenApi.exportKey()
            print("private Key: \(key)")
            
            let qrcodeImage = generateQRCodeImage(key)
            displayQRCodeImage(image: qrcodeImage)
        } catch {
            print("error in ExportViewController: \(error)")
        }
    }
    
    func generateQRCodeImage(_ text: String) -> CIImage? {
        // 이더리움 주소로 QR코드 변환하기
        let data = text.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")
        
        return filter?.outputImage
    }
    
    func displayQRCodeImage(image: CIImage?) {
        if let qrImage = image {
            let scaleX = qrcodeImageView.frame.size.width / qrImage.extent.size.width
            let scaleY = qrcodeImageView.frame.size.height / qrImage.extent.size.height
            
            let transformedImage = qrImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
            
            qrcodeImageView.image = UIImage(ciImage: transformedImage)
        }
    }
    
    @IBAction func closeView(sender: AnyObject?) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

