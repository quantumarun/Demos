//
//  ViewController.swift
//  TypeAliasDemo
//
//  Created by Arun on 4/25/17.
//  Copyright © 2017 Arun. All rights reserved.
//

import UIKit

typealias Even = (String, Int) -> Void
typealias Odd = (Error) -> Void

class ViewController: UIViewController {
    @IBOutlet weak var txtLbl: UILabel!

    var i = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    @IBAction func CallFunction(_ sender: UIButton) {
        testTypeAlias(even: { str, num in
            txtLbl.text = "\(str) \(num)"
        }, odd: { err in
            txtLbl.text = err.localizedDescription
        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testTypeAlias(even: Even, odd: Odd) {
        if (i % 2 == 0) {
            even("This is an Even number: ", i)
            i += 1
        } else {
            let err = NSError(domain: "", code: i, userInfo: nil)
            odd(err)
            i += 1
        }
    }
    

}

