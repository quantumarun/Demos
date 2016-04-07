//
//  OpenQRVC.swift
//  QRCoder
//
//  Created by Arun on 3/21/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import Foundation
import UIKit

class OpenQRVC: UIViewController {
    
    @IBOutlet weak var qrCodeLabel: UILabel!
    
    @IBOutlet weak var qrImage: UIImageView!
    
    @IBAction func openQRBtnAction(sender: UIButton) {
        if let text = qrCodeLabel.text {
            if let qrURL:NSURL = NSURL(string:text) {
                let application:UIApplication = UIApplication.sharedApplication()
                if (application.canOpenURL(qrURL)) {
                    application.openURL(qrURL);
                }
            }
        }
    }
    
    @IBAction func shareQRBtnAction(sender: UIButton) {
        
    }
    
}
