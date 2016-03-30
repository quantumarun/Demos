//
//  ViewController.swift
//  PopOverDemo
//
//  Created by Arun on 3/30/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, UIAdaptivePresentationControllerDelegate, SortViewControllerDelegate {

    @IBAction func sortItems(sender: UIBarButtonItem) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let sortPopOverVC: sortPopOverController = storyboard.instantiateViewControllerWithIdentifier("sortVC") as! sortPopOverController
        sortPopOverVC.modalPresentationStyle = .Popover
        sortPopOverVC.preferredContentSize = CGSizeMake(300, 250)
        sortPopOverVC.delegate = self
        let popoverMenuViewController = sortPopOverVC.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .Any
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.barButtonItem = sender as UIBarButtonItem
        presentViewController(sortPopOverVC, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle{
        return .None
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sortSelection(selectedItem: Int) {
        print("Index Selected: \(selectedItem)")
    }

}

