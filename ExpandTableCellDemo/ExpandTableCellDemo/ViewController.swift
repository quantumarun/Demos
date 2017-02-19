//
//  ViewController.swift
//  ExpandTableCellDemo
//
//  Created by Arun on 4/25/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var expandTableView: UITableView!
    var selectedIndex = -1
    var dataArray : [[String:String]] = [["MatchName" : "First Match", "Team1" : "US", "Team2" : "Australia", "Score" : "Score 1-0"], ["MatchName" : "Second Match", "Team1" : "India", "Team2" : "Sri lanka", "Score" : "Score 2-0"], ["MatchName" : "Third Match", "Team1" : "West Indies", "Team2" : "South Africa", "Score" : "Score 2-4"], ["MatchName" : "Fourth Match", "Team1" : "New Zealand", "Team2" : "Holland", "Score" : "Score 0-0"] ]
    
    var summaryArray = ["Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
                        "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.",
                        "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        expandTableView.estimatedRowHeight = 40
        expandTableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! customCell
        cell.selectionStyle = .none
        let obj = dataArray[indexPath.row]
        cell.matchName.text = obj["MatchName"]
        cell.team1.text = obj["Team1"]
        cell.team2.text = obj["Team2"]
        cell.score.text = obj["Score"]
        cell.summaryLabel.text = summaryArray[indexPath.row]
        cell.summaryLabel.frame = self.cellSummaryLabelFrame(cell: cell, selectedIndexPath: indexPath)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(selectedIndex == indexPath.row) {
            //return 100;
            return self.calculateHeight(selectedIndexPath: indexPath)
        } else {
            return 40;
        }
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(selectedIndex == indexPath.row) {
            selectedIndex = -1
        } else {
            selectedIndex = indexPath.row
        }
        self.expandTableView.beginUpdates()
        //self.expandTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic )
        self.expandTableView.endUpdates()
    }
    
    func calculateHeight(selectedIndexPath: IndexPath) -> CGFloat {
        let cell = self.expandTableView.cellForRow(at: selectedIndexPath) as! customCell
        cell.summaryLabel.frame = self.cellSummaryLabelFrame(cell: cell, selectedIndexPath: selectedIndexPath)
        return 40 + 35 + 21 + 10 + cell.summaryLabel.frame.size.height + 10
    }
    
    func cellSummaryLabelFrame(cell: customCell, selectedIndexPath: IndexPath) -> CGRect {
        cell.summaryLabel.text = summaryArray[selectedIndexPath.row]
        cell.summaryLabel.numberOfLines = 0
        var labelFrame = cell.summaryLabel.frame
        let maxSize = CGSize.init(width: cell.summaryLabel.frame.size.width, height: CGFloat.greatestFiniteMagnitude)
        let requiredSize = cell.summaryLabel.sizeThatFits(maxSize)
        labelFrame.size.height = requiredSize.height
        return labelFrame
    }


}

