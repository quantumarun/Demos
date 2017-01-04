 //
//  customCell.swift
//  ExpandTableCellDemo
//
//  Created by Arun on 4/25/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import UIKit

protocol CustomCellDelegate: class {
    func updateTableView(row: Int)
    func navigateToDetail(row: Int)
}

class customCell: UITableViewCell {

    @IBOutlet weak var matchName: UILabel!
    @IBOutlet weak var firstViewBtn: UIButton!
    @IBOutlet weak var team1: UILabel!
    @IBOutlet weak var team2: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var secondViewBtn: UIButton!
    @IBOutlet weak var heightConstraintSecondView: NSLayoutConstraint!
    
    weak var delegate: CustomCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func ShowHideSecondView(_ sender: UIButton) {
        print("First View: \(sender.tag)")
        delegate?.updateTableView(row: sender.tag)
    }
    
    @IBAction func ShowDetail(_ sender: UIButton) {
        print("Second View: \(sender.tag)")
        delegate?.navigateToDetail(row: sender.tag)
    }

}
