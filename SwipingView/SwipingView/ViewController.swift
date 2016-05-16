//
//  ViewController.swift
//  SwipingView
//
//  Created by Arun on 5/9/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    var displayString: String?
    var quotes = ["Geometrics", "Vectors", "Celebration", "Triangle",      "Landscapes", "Seasons", "Snow", "Rain", "Sunrays", "Stencils", "Paint", "Graphics", "Graffiti", "Sports","Fashion","Ancient Greek", "Philosophers", "Fairy tales", "Fantasy", "Clouds", "Mystery", "Time Clocks", "Canvas", "Tie-dye", "Glitter", "Dessert", "Desert", "Energy", "Astrology", "Solar Systems", "Sea", "Beach", "Sphere", "Roots", "Lights", "Darks", "Fire", "Air", "Aperture", "Long exposure", "Portraits", "World", "Travel", "Architecture", "Freedom", "Old", "New", "Urban", "Lenses", "Fisheye", "Chords", "Music notes", "Spices", "Herbs", "Natural", "Marbles", "Wood", "Trees", "Forests", "Interior","Mammals", "Reptiles", "Ocean", "Birds", "Photography", "Exposure", "Opaque", "Translucent", "Freestyle", "Spots", "Stripes", "Zig Zag", "Spiral", "Glass", "Feathers", "Calm", "Bulb", "Heat", "Cold", "Stitches", "Views", "Birds", "Sunset", "Earth"]
    
    var whichQuotestoChoose = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.viewSwipped(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        view1.addGestureRecognizer(swipeLeft)
        
        let swipeLeft1 = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.viewSwipped(_:)))
        swipeLeft1.direction = UISwipeGestureRecognizerDirection.Left
        view2.addGestureRecognizer(swipeLeft1)
    }
    
    func viewSwipped(gesture: UIGestureRecognizer) {
        self.chooseAQuote()
    
        if let swippedView = gesture.view {
            //swippedView.slideInFromRight()
            if swippedView.tag == 1 {
                label1.leftToRightAnimation()
                label1.text = displayString
            } else {
                label2.leftToRightAnimation()
                label2.text = displayString
            }
        }
    }
    
    func chooseAQuote() {
        displayString = quotes[whichQuotestoChoose]
        whichQuotestoChoose = Int(arc4random_uniform (84))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UIView {
    func leftToRightAnimation(duration: NSTimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        // Create a CATransition object
        let leftToRightTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided
        if let delegate: AnyObject = completionDelegate {
            leftToRightTransition.delegate = delegate
        }
        
        leftToRightTransition.type = kCATransitionPush
        leftToRightTransition.subtype = kCATransitionFromRight
        leftToRightTransition.duration = duration
        leftToRightTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        leftToRightTransition.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        self.layer.addAnimation(leftToRightTransition, forKey: "leftToRightTransition")
    }
}



