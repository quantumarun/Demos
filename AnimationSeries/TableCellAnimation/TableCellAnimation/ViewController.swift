//
//  ViewController.swift
//  TableCellAnimation
//
//  Created by Arun Gupta on 08/02/17.
//  Copyright © 2017 Arun Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var subtitleTV: UITableView!
    var titleHeading : [String] = ["John", "Adam", "Shilpa", "Jennifer", "Sia"]
    var subtitleHeading: [String] = ["25", "40", "20", "18", "25"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func deleteItem(_ sender: UIBarButtonItem) {
        let indexPath = IndexPath.init(row: 0, section: 0)
        titleHeading.remove(at: 0)
        subtitleHeading.remove(at: 0)
        subtitleTV.deleteRows(at: [indexPath], with: .right)
    }

    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let indexPath = IndexPath.init(row: 0, section: 0)
        titleHeading.insert("Monica", at: 0)
        subtitleHeading.insert("23", at: 0)
        subtitleTV.insertRows(at: [indexPath], with: .left)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleHeading.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = titleHeading[indexPath.row]
        cell.detailTextLabel?.text = subtitleHeading[indexPath.row]
        return cell
    }
}

