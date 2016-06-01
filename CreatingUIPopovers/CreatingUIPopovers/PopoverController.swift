//
//  PopoverController.swift
//  CreatingUIPopovers
//
//  Created by Arun on 5/27/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import Foundation
import UIKit

protocol SelectionViewControllerDelegate: class {
    func selection(selectedItem: Int)
}


class PopoverController: UITableViewController {
    
    var items: [String] = []
    
    weak var delegate: SelectionViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.preferredContentSize = self.tableView.contentSize
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableRow", forIndexPath: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.dismissViewControllerAnimated(false, completion: {()->Void in
            self.delegate?.selection(indexPath.row)
        });
    }
    
}
