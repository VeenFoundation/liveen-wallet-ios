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
    @IBOutlet weak var addressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true;
        
        do {
            let veenApi = try VeenAPI()
            let account = try veenApi.getAccount()
            
            print("Get user address: \(account.publicAddress)")
            
            self.addressLabel.text = account.publicAddress
            
            let qrcodeImage = generateQRCodeImage(account.publicAddress)
            displayQRCodeImage(image: qrcodeImage)
        } catch {
            print("error in ReceiveViewController: \(error)")
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
    
    @IBAction func copyWalletAddressClick(_ sender: Any) {
        let address = addressLabel.text!
        UIPasteboard.general.string = address
        
        let alertController = UIAlertController(title: "Notice", message: "Copied in Clipboard", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
}


