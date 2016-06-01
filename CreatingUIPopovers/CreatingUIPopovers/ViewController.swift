//
//  ViewController.swift
//  CreatingUIPopovers
//
//  Created by Arun on 5/27/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, SelectionViewControllerDelegate {

    let items = ["One", "Two", "Three", "Four", "Five"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showPopover(sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popOverVC: PopoverController =
            storyboard.instantiateViewControllerWithIdentifier("PopVC") as! PopoverController
        popOverVC.items = items
        popOverVC.modalPresentationStyle = .Popover
        popOverVC.preferredContentSize = CGSizeMake(300, 250)
        popOverVC.delegate = self
        let popoverMenuViewController = popOverVC.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .Any
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = sender
        popoverMenuViewController?.sourceRect = CGRectMake(0, 0, sender.frame.size.width, sender.frame.size.height)
        presentViewController(popOverVC, animated: true, completion: nil)
    }
    
    
    @IBAction func showPopoverfromBarButton(sender: UIBarButtonItem) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popOverVC: PopoverController =
            storyboard.instantiateViewControllerWithIdentifier("PopVC") as! PopoverController
        popOverVC.items = items
        popOverVC.modalPresentationStyle = .Popover
        popOverVC.preferredContentSize = CGSizeMake(300, 250)
        popOverVC.delegate = self
        let popoverMenuViewController = popOverVC.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .Any
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.barButtonItem = sender as UIBarButtonItem
        presentViewController(popOverVC, animated: true, completion: nil)
    }
    
    func selection(selectedItem: Int) {
        print("Selected Index: \(selectedItem), Item: \(items[selectedItem])")
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .None
    }

}

