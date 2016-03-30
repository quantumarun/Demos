//
//  sortPopOverController.swift
//  PopOverDemo
//
//  Created by Arun on 3/30/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import Foundation
import UIKit

protocol SortViewControllerDelegate: class {
    func sortSelection(selectedItem: Int)
}

class sortPopOverController: UITableViewController {
    
    weak var delegate:SortViewControllerDelegate?
    
    let sortOptions = ["Date Added", "Film name", "Our star rating", "Highest rated", "Lowest rated"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("options", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text=sortOptions[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.dismissViewControllerAnimated(false, completion: {()->Void in
            print("done");
            self.delegate?.sortSelection(indexPath.row)
        });
        
        //self.presentedViewController!.dismissViewControllerAnimated(true, completion: nil)
        //delegate?.sortSelection(indexPath.row)
    }
    
    
    
    
}
