//
//  SendViewController.swift
//  LiveenWallet
//
//  Created by 이도현 on 2018. 4. 23..
//  Copyright © 2018년 veenfoundation. All rights reserved.
//

import AVFoundation
import UIKit
import TextFieldEffects
import KeychainAccess
import QRCodeReader

class SendViewController: UIViewController, QRCodeReaderViewControllerDelegate {
    
  
    @IBOutlet weak var previewView: QRCodeReaderView! {
        didSet {
            previewView.setupComponents(showCancelButton: false, showSwitchCameraButton: false, showTorchButton: false, showOverlayView: true, reader: reader)
        }
    }
    lazy var reader: QRCodeReader = QRCodeReader()
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader          = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            $0.showTorchButton = true
            
            $0.reader.stopScanningWhenCodeIsFound = false
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    @IBOutlet var inputArea:UIStackView!
    var amountField : HoshiTextField!
    var addressField : HoshiTextField!
    var passwordField : HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hid navigation bar
        self.navigationController?.navigationBar.isHidden = true
        displayInputFields()
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func displayInputFields() {
        amountField = HoshiTextField()
        amountField.placeholderColor = .white
        amountField.borderInactiveColor = .white
        amountField.borderActiveColor = .white
        amountField.textColor = .white
        amountField.placeholder = "Amount"
        amountField.keyboardType = .numberPad
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addressField = HoshiTextField()
        addressField.placeholderColor = .white
        addressField.borderInactiveColor = .white
        addressField.borderActiveColor = .white
        addressField.textColor = .white
        addressField.placeholder = "To Address"
        addressField.invalidateIntrinsicContentSize()
        
        let button = UIButton()
        button.setImage(UIImage(named: "ic_qrcode"), for: .normal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.addTarget(self, action: #selector(self.qrButtonClick), for: .touchUpInside)
        
        stackView.addArrangedSubview(addressField)
        stackView.addArrangedSubview(button)
        
        passwordField = HoshiTextField()
        passwordField.placeholderColor = .white
        passwordField.borderInactiveColor = .white
        passwordField.borderActiveColor = .white
        passwordField.textColor = .white
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        
        inputArea.addArrangedSubview(amountField)
        inputArea.addArrangedSubview(stackView)
        inputArea.addArrangedSubview(passwordField)
    }
    
    // MARK: - Actions
    
    private func checkScanPermissions() -> Bool {
        do {
            return try QRCodeReader.supportsMetadataObjectTypes()
        } catch let error as NSError {
            let alert: UIAlertController
            
            switch error.code {
            case -11852:
                alert = UIAlertController(title: "Error", message: "This app is not authorized to use Back Camera.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (_) in
                    DispatchQueue.main.async {
                        if let settingsURL = URL(string: UIApplicationOpenSettingsURLString) {
                            UIApplication.shared.openURL(settingsURL)
                        }
                    }
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            default:
                alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            }
            
            present(alert, animated: true, completion: nil)
            
            return false
        }
    }
    
  

    //MARK: IBAction
    
    @IBAction func scanInModalAction(_ sender: AnyObject) {
        guard checkScanPermissions() else { return }
        
        readerVC.modalPresentationStyle = .formSheet
        readerVC.delegate               = self
        
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            if let result = result {
                print("Completion with result: \(result.value) of type \(result.metadataType)")
            }
        }
        
        present(readerVC, animated: true, completion: nil)
    }
    
    @objc func qrButtonClick() {
        print("qrButton click")
        
        scanInModalAction(self)
    }
    
    @IBAction func nextButtonClick(_ sender: Any) {
        print("nextButton")
    }
    
    
    @IBAction func chargeGasButtonClick(_ sender: Any) {
        print("charge Gas")
    }
    
    @IBAction func closeView(sender: AnyObject?) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: QRCodeReader Delegate
    
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
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        
        dismiss(animated: true) { [weak self] in
            
            
//            let alert = UIAlertController(
//                title: "QRCodeReader",
//                message: String (format:"%@ (of type %@)", result.value, result.metadataType),
//                preferredStyle: .alert
//            )
//            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//
//            self?.present(alert, animated: true, completion: nil)
            
            
            let matched = self?.matches(for:"^0x[a-fA-F0-9]{40}$", in: result.value)
            if(matched == false) {
                print("주소형식이 아닐경우")
                let alertController = UIAlertController(title: "Notice", message: "This is not valid liveen address, check again", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                self?.present(alertController, animated: true, completion: nil)
                
                return
            }
            
            self?.addressField.text = String (format:"%@", result.value)
            
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
    }
    
}
