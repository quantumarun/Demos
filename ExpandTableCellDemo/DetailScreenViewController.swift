//
//  DetailScreenViewController.swift
//  ExpandTableCellDemo
//
//  Created by Arun Gupta on 04/01/17.
//  Copyright © 2017 Arun. All rights reserved.
//

import UIKit

class DetailScreenViewController: UIViewController {
    @IBOutlet weak var teamLbl: UILabel!
    @IBOutlet weak var scoresLbl: UILabel!
    
    private var team1: String? = nil
    private var team2: String? = nil
    private var score: String? = nil
    
    public func getTeam1() -> String {
        return self.team1!
    }
    public func getTeam2() -> String {
        return self.team2!
    }
    public func getScore() -> String {
        return self.score!
    }
    
    public func setTeam1 (t1: String) {
        self.team1 = t1
    }

    public func setTeam2 (t2: String) {
        self.team2 = t2
    }

    public func setScore (sc: String) {
        self.score = sc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Match Scoreboard"
        
        self.teamLbl.text = "Match held between \(getTeam1()) and \(getTeam2())"
        self.scoresLbl.text = "Scoreboard: \(getScore())"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
