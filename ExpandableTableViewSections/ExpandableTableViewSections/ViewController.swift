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
    var row1 = ["Tomato", "Onion", "Potato", "Pumpkin", "Babycorn", "Cucumber", "Carrot", "Beans", "Cabbage", "Corn", "EggPlant", "Pea", "Sweet Potato"]
    var row2 = ["Mango", "Orange", "Watermelon", "Apple", "Apricot", "Banana", "Papaya", "Pineapple", "Melon", "Avocado", "Cherry", "Date", "Fig", "Grape", "Guava", "Kiwi", "Olive", "Pear"]
    var row3 = ["Parrot", "Peacock", "Woodpecker", "Kingfisher", "Owl", "Eagle", "Pigeon", "Vulture", "Bats", "Nightingale", "Crow"]
    var row4 = ["Lizard", "Crocodile", "Snake", "Turtle", "Dinosaur"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func sectionTapped(_ sender: UIButton) {
        //print("section Tapped")
        let section = sender.tag
        let shouldExpand = !expandedSections.contains(section)
        if (shouldExpand) {
            expandedSections.removeAllObjects()
            expandedSections.add(section)
        } else {
            expandedSections.removeAllObjects()
        }
        self.expandTableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: 300, height: 28))
        var imageView = UIImageView()
        if (expandedSections.contains(section)) {
            imageView = UIImageView.init(frame: CGRect(x: 10, y: 10, width: 18, height: 10))
            imageView.image = UIImage(named: "down-arrow")
        } else {
            imageView = UIImageView.init(frame: CGRect(x: 10, y: 15, width: 10, height: 18))
            imageView.image = UIImage(named: "right-arrow")
        }
        
        let headerTitle = UILabel.init(frame: CGRect(x: 38, y: 4, width: 250, height: 28))
        headerTitle.text = sectionData[section]
        
        let tappedSection = UIButton.init(frame: CGRect(x: 0, y: 0, width: headerView.frame.size.width, height: headerView.frame.size.height))
        tappedSection.addTarget(self, action: #selector(sectionTapped), for: .touchUpInside)
        tappedSection.tag = section
        
        headerView.addSubview(imageView)
        headerView.addSubview(headerTitle)
        headerView.addSubview(tappedSection)
        headerView.backgroundColor = UIColor.lightGray
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(expandedSections.contains(section)) {
            switch section {
            case 0:
                return row1.count
            case 1:
                return row2.count
            case 2:
                return row3.count
            default:
                return row4.count
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        switch indexPath.section {
        case 0:
            cell?.textLabel?.text = row1[indexPath.row]
        case 1:
            cell?.textLabel?.text = row2[indexPath.row]
        case 2:
            cell?.textLabel?.text = row3[indexPath.row]
        default:
            cell?.textLabel?.text = row4[indexPath.row]
        }
        return cell!;
    }
}

