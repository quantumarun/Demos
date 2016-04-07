//
//  GenerateQRVC.swift
//  QRCoder
//
//  Created by Arun on 3/21/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import Foundation
import UIKit

class GenerateQRVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var qrTextField: UITextField!
    @IBOutlet weak var generateQRBtn: UIButton!
    @IBOutlet weak var qrImageView: UIImageView!
    var qrCode: CIImage!
    
    override func viewDidLoad() {
        self.qrTextField.delegate = self
        self.generateQRBtn.alpha = 0.5
        self.generateQRBtn.userInteractionEnabled = false
    }
    
    
    @IBAction func generateBtnAction(sender: UIButton) {
        if qrCode == nil {
            if qrTextField.text == "" {
                return
            }
            let data = qrTextField.text?.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
            let filter = CIFilter(name: "CIQRCodeGenerator")
            filter?.setValue(data, forKey: "inputMessage")
            filter?.setValue("Q", forKey: "inputCorrectionLevel")
            qrCode = filter?.outputImage
            self.qrCodeImage()
            qrTextField.resignFirstResponder()
            generateQRBtn.setTitle("Clear", forState: UIControlState.Normal)
        } else {
            qrCode = nil
            qrImageView.image = nil
            generateQRBtn.setTitle("Generate", forState: UIControlState.Normal)
        }
    }
    func qrCodeImage () {
        let scaleX = qrImageView.frame.size.width / qrCode.extent.size.width
        let scaleY = qrImageView.frame.size.height / qrCode.extent.size.height
        let transformedImage = qrCode.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
        qrImageView.image = UIImage(CIImage: transformedImage)
        
        //let actualImage = UIImage(CIImage: transformedImage)
        let data = self.createImage()
        if let data = data {
            let filename = getDocumentsDirectory().stringByAppendingPathComponent("myQR.png")
            data.writeToFile(filename, atomically: true)
        }
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        print("Path: \(documentsDirectory)")
        return documentsDirectory
    }
    
    func createImage () -> NSData? {
        let originalImage = qrImageView.image
        let destinationSize = CGSizeMake(qrImageView.frame.size.width, qrImageView.frame.size.height)
        UIGraphicsBeginImageContext(destinationSize)
        originalImage?.drawInRect(CGRectMake(0, 0, destinationSize.width, destinationSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        let data = UIImagePNGRepresentation(newImage)
        UIGraphicsEndImageContext()
        return data!
    }
    
    
    // MARK: UITextField Delegates
   func textFieldShouldBeginEditing(textField: UITextField) -> Bool { // return NO to disallow editing.
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool { // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        if ((textField.text?.isEmpty ) == nil){
            print("if called for isEmpty")
        }
        
        if let _ = textField.text {
            let whitespaceSet = NSCharacterSet.whitespaceCharacterSet()
            if textField.text!.stringByTrimmingCharactersInSet(whitespaceSet) != "" {
                self.generateQRBtn.alpha = 1.0
                self.generateQRBtn.userInteractionEnabled = true
            } else {
                self.generateQRBtn.alpha = 0.5
                self.generateQRBtn.userInteractionEnabled = false
            }
        } else {
            self.generateQRBtn.alpha = 0.5
            self.generateQRBtn.userInteractionEnabled = false
        }
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) { // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool { // return NO to not change text
        if let _ = textField.text {
            let whitespaceSet = NSCharacterSet.whitespaceCharacterSet()
            if textField.text!.stringByTrimmingCharactersInSet(whitespaceSet) != "" {
                self.generateQRBtn.alpha = 1.0
                self.generateQRBtn.userInteractionEnabled = true
            } else {
                self.generateQRBtn.alpha = 0.5
                self.generateQRBtn.userInteractionEnabled = false
            }
        } else {
            self.generateQRBtn.alpha = 0.5
            self.generateQRBtn.userInteractionEnabled = false
        }
        return true
    }
    
    
    func textFieldShouldClear(textField: UITextField) -> Bool { // called when clear button pressed. return NO to ignore (no notifications)
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool { // called when 'return' key pressed. return NO to ignore.
        textField.resignFirstResponder()
        return true
    }
}
