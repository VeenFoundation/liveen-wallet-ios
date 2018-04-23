//
//  ReceiveViewController.swift
//  LiveenWallet
//
//  Created by 이도현 on 2018. 4. 23..
//  Copyright © 2018년 veenfoundation. All rights reserved.
//

import UIKit

class ReceiveViewController: UIViewController {
    @IBOutlet var qrcodeImageView:UIImageView!
    @IBOutlet var copyAddressButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true;
        
        let qrcodeImage = generateQRCodeImage("0x93BC4bec6D678e8e74bB9EC3e1Be5EDfA608e2B6")
        displayQRCodeImage(image: qrcodeImage)
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


