//
//  ViewController.swift
//  ExpandableTableViewSections
//
//  Created by Arun on 7/31/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var expandTableView: UITableView!
    var expandedSections : NSMutableSet = []
    var sectionData : [String] = ["Vegs", "Fruits",  "Birds", "Reptiles"]
    var row1 = ["Tomato", "Onion", "Potato", "Pumpkin", "Babycorn", "Cucumber"]
    var row2 = ["Mango", "Orange", "Watermelon", "Apple", "Apricot", "Banana"]
    var row3 = ["Parrot", "Peacock", "Woodpecker", "Kingfisher", "Owl", "Eagle"]
    var row4 = ["Lizard", "Crocodile", "Snake", "Turtle", "Dinosaur"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func sectionTapped(sender: UIButton) {
        //print("section Tapped")
        let section = sender.tag
        let shouldExpand = !expandedSections.containsObject(section)
        if (shouldExpand) {
            expandedSections.removeAllObjects()
            expandedSections.addObject(section)
        } else {
            expandedSections.removeAllObjects()
        }
        self.expandTableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionData.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRectMake(0, 0, 300, 28))
        var imageView = UIImageView()
        if (expandedSections.containsObject(section)) {
            imageView = UIImageView.init(frame: CGRectMake(10, 10, 18, 10))
            imageView.image = UIImage(named: "down-arrow")
        } else {
            imageView = UIImageView.init(frame: CGRectMake(10, 15, 10, 18))
            imageView.image = UIImage(named: "right-arrow")
        }
        
        let headerTitle = UILabel.init(frame: CGRectMake(38, 4, 250, 28))
        headerTitle.text = sectionData[section]
        
        let tappedSection = UIButton.init(frame: CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height))
        tappedSection.addTarget(self, action: #selector(sectionTapped), forControlEvents: .TouchUpInside)
        tappedSection.tag = section
        
        headerView.addSubview(imageView)
        headerView.addSubview(headerTitle)
        headerView.addSubview(tappedSection)
        return headerView
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(expandedSections.containsObject(section)) {
            switch section {
            case 1:
                return row1.count
            case 2:
                return row2.count
            case 3:
                return row3.count
            default:
                return row4.count
            }
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        
        switch indexPath.section {
        case 1:
            cell?.textLabel?.text = row1[indexPath.row]
        case 2:
            cell?.textLabel?.text = row2[indexPath.row]
        case 3:
            cell?.textLabel?.text = row3[indexPath.row]
        default:
            cell?.textLabel?.text = row4[indexPath.row]
        }
        return cell!;
    }
}

