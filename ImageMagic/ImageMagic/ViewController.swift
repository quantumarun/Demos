//
//  ViewController.swift
//  ImageMagic
//
//  Created by Arun Gupta on 11/03/17.
//  Copyright © 2017 Arun Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        image1.tintColor = UIColor.red
        image2.tintColor = UIColor.blue
        image3.tintColor = UIColor.darkGray
        image4.tintColor = UIColor.green
        
        image1.image = #imageLiteral(resourceName: "DeleteFill")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

