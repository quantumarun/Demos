//
//  ViewController.swift
//  TextViewLikeWhatsApp
//
//  Created by alex on 6/16/16.
//  Copyright © 2016 MOSTELECOM. All rights reserved.
//

import UIKit

//let chats: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17"]

class ViewController: UIViewController {
 
    @IBOutlet weak var textViewContainer: UIView!
    @IBOutlet weak var tv: UITextView!
    
    @IBOutlet weak var table: UITableView!
   // @IBOutlet weak var bubbleImg: UIImageView!
   
    @IBOutlet weak var tvHeightConstraint: NSLayoutConstraint!
    
    var textEntered = ""
    
    var messages: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        //Hide and show keyboard when tapping TextViews
        //222
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
        view.addGestureRecognizer(dismiss)
        
        self.configureImage()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
        //222
        
        table.reloadData()
        tableScrollToTheEnd(true)
    }
    
    func configureImage () {
        self.tv.layer.cornerRadius = 5.0
        self.tv.layer.borderColor = UIColor.gray.cgColor
        self.tv.layer.borderWidth = 2.0
        //self.tv.textContainerInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        /*
         let edgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
         let backGroundImage = #imageLiteral(resourceName: "Chat_Bubble_Green_1.png") .resizableImage(withCapInsets: edgeInsets)
         self.bubbleImg.image = backGroundImage
        */
        
        /*
        UIGraphicsBeginImageContext(self.textViewContainer.frame.size)
        UIImage.init(named: "Chat_Bubble_Green_1")?.drawAsPattern(in: self.textViewContainer.bounds)
        //draw(in: self.textViewContainer.bounds)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.textViewContainer.backgroundColor = UIColor(patternImage:scaledImage!)
        self.textViewContainer.contentMode = .scaleToFill
        //self.textViewContainer.contentMode = UIViewContentMode.ScaleAspectFill
        */
    }

    
    @IBAction func postMsg(_ sender: UIButton) {
        if messages == nil {
            self.messages = []
        }
        
        self.messages?.append(self.tv.text)
        view.endEditing(true)
        self.table.reloadData()
    
    }
    
    func DismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func keyboardWillShow(_ sender: Notification) {
        // 1
        let userInfo: [AnyHashable: Any] = sender.userInfo!
        // 2
        let keyboardSize: CGSize = (userInfo[UIKeyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue.size
        let offset: CGSize = (userInfo[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
        // 3
        if keyboardSize.height == offset.height {
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.view.frame.origin.y -= keyboardSize.height
            })
        } else {
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.view.frame.origin.y += keyboardSize.height - offset.height
            })
        }
        
        tableScrollToTheEnd(true)
    }
    
    func keyboardWillHide(_ sender: Notification) {
        let userInfo: [AnyHashable: Any] = sender.userInfo!
        let keyboardSize: CGSize = (userInfo[UIKeyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue.size
        self.view.frame.origin.y += keyboardSize.height
        
        tableScrollToTheEnd(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }

    
    
    func tableScrollToTheEnd(_ animated: Bool) {
        DispatchQueue.main.async(execute: {
            if self.messages != nil {
                let indexPath = IndexPath(row: (self.messages?.count)! - 1, section: 0)
                self.table.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: animated)
            }
            
        })
        /*let delay = 0.1 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            
            let numberOfSections = self.table.numberOfSections
            let numberOfRows = self.table.numberOfRowsInSection(numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: (numberOfSections-1))
                self.table.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: animated)
            }
            
        })
         */
        
        /*
        let indexPath = NSIndexPath(forRow: chats.count - 1, inSection: 0)
        table.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
        print("keyboard should scroll")
         */
        
        /*
        let sections = table.numberOfSections
        let rows = table.numberOfRowsInSection(sections - 1)
        table.scrollToRowAtIndexPath(NSIndexPath(forRow: rows - 1, inSection: sections - 1), atScrollPosition: .Bottom, animated: true)
         */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Code to work with TableView
    //111
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if messages != nil {
            return messages!.count
        }
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
        
        cell.textLabel?.layer.cornerRadius = 5.0
        cell.textLabel?.layer.borderWidth = 1.0
        cell.textLabel?.layer.borderColor = UIColor.blue.cgColor
        cell.textLabel?.text = messages?[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
    //CODE TO BE RUN ON CELL TOUCH
    }
    //111
}

//It is needed because it is only one known to me working way to make Text view like WhatsApp.
extension ViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        /*
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        var newFrame = textView.frame
        
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        //print("New Height: \(newFrame.height) and Height Constraint: \(self.tvHeightConstraint.constant)")
        
        if (self.tv.contentSize.height < self.tvHeightConstraint.constant) {
            self.tvHeightConstraint.constant = newFrame.height
            //print("Inside If New Height: \(newFrame.height) and Height Constraint: \(self.tvHeightConstraint.constant)")
        } else {
            if(self.tvHeightConstraint.constant <= 100) {
                self.tvHeightConstraint.constant = newFrame.height
                self.tv.isScrollEnabled = false
                //print("Inside Else if New Height: \(newFrame.height) and Height Constraint: \(self.tvHeightConstraint.constant)")
            } else {
                self.tv.isScrollEnabled = true
                //print("Inside Else Else New Height: \(newFrame.height) and Height Constraint: \(self.tvHeightConstraint.constant)")
            }
        }
 */
        if self.tv.contentSize.height < self.tvHeightConstraint.constant {
            self.tv.isScrollEnabled = false
        } else {
            self.tv.isScrollEnabled = true
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        //print("shouldChangeTextIn")
        //print("tv.contentSize.height: \(tv.contentSize.height)")
        //print("tvHeightConstraint.constant: \(tvHeightConstraint.constant)")
        /*
        if (text == "\n")    {
            self.tvHeightConstraint.constant = self.tv.contentSize.height + 24.0
        }
 
        
        
        if self.tv.contentSize.height < self.tvHeightConstraint.constant {
            self.tv.isScrollEnabled = false
        } else {
            self.tv.isScrollEnabled = true
        }
    */
        return true
    }
    
    /*
    func textViewDidChangeSelection(_ textView: UITextView) {
        print("textViewDidChangeSelection")
        print("tv.contentSize.height: \(tv.contentSize.height)")
        print("tvHeightConstraint.constant: \(tvHeightConstraint.constant)")
        /*
        if self.tv.contentSize.height < self.tvHeightConstraint.constant {
            self.tv.scrollEnabled = false
            //tvHeightConstraint.constant = 33.0
        } else {
            self.tv.scrollEnabled = true
        }
        */
    }
     */
    override func didChange(_ changeKind: NSKeyValueChange, valuesAt indexes: IndexSet, forKey key: String) {
        print("LALALa")
    }
}
