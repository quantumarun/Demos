//
//  ScanQRVC.swift
//  QRCoder
//
//  Created by Arun on 3/21/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class ScanQRVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    var capturedImage: UIImage?
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()
        qrCodeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
        qrCodeFrameView?.layer.borderWidth = 2
        view.addSubview(qrCodeFrameView!)
        view.bringSubviewToFront(qrCodeFrameView!)
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
        // as the media type parameter.
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        // Get an instance of the AVCaptureDeviceInput class using the previous device object.
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice) as AVCaptureDeviceInput
            // moved the rest of the image capture into the do{} scope.
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            // Set the input device on the capture session.
            captureSession?.addInput(input as AVCaptureInput)
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(self.videoPreviewLayer!)
            // Start video capture.
            captureSession?.startRunning()
            // Move the message label to the top view
            view.bringSubviewToFront(self.messageLabel)
        } catch let error as NSError {
            print("\(error.localizedDescription)")
        }
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            self.qrCodeFrameView?.frame = CGRectZero
            self.messageLabel.text = "No QR code is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = barCodeObject.bounds;
            
            print("Detected")
            if metadataObj.stringValue != nil {
                self.messageLabel.text = metadataObj.stringValue
//                UIGraphicsBeginImageContext(self.view.frame.size)
//                view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
//                self.capturedImage = UIGraphicsGetImageFromCurrentImageContext()
//                UIGraphicsEndImageContext()
//                let data = UIImagePNGRepresentation(self.capturedImage!)
//                if let data = data {
//                    let filename = getDocumentsDirectory().stringByAppendingPathComponent("ScannedQR.png")
//                    data.writeToFile(filename, atomically: true)
//                }
                self.captureSession?.stopRunning();

                self.performSegueWithIdentifier("OpenQR", sender: self)
                //let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //let openQR = storyboard.instantiateViewControllerWithIdentifier("OpenQR") as! OpenQRVC
                //openQR.qrCodeLabel.text = "http://google.com"
               
                //Save it to the camera roll
                //openQR.qrImage.image = image
               // self.navigationController?.pushViewController(openQR, animated: true)
            }
        }
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        print("Path: \(documentsDirectory)")
        return documentsDirectory
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "OpenQR") {
            if let openQR  = segue.destinationViewController as? OpenQRVC {
                openQR.qrCodeLabel.text = self.messageLabel.text
                openQR.qrImage.image = self.capturedImage
            }
        }
    }
}
