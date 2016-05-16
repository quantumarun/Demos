//
//  ViewController.swift
//  AdaptiveUILabel
//
//  Created by Arun on 5/16/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    var count = 0
    
    let items = ["Jack and Jill went up the hill, to fetch a pail of water.", "Jonny jonny yes papa eating sugar no papa", "DJ", "A Little seed, For me to sow. A little earth, To help it grow. A little sun, A little shower, A little while, And then - A FLOWER!"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func changeText(sender: UIButton) {
        if(self.count > 3) {
            self.count = 0
        }
        self.textLabel.text = items[count]
        self.count = self.count + 1
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

