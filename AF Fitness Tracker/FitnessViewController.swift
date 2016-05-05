//
//  FitnessViewController.swift
//  AF Fitness Tracker
//
//  Created by Tony Gresko on 4/26/16.
//  Copyright © 2016 Tony Gresko. All rights reserved.
//

import UIKit

class FitnessViewController: UIViewController, UINavigationControllerDelegate {

    //MARK: Properties
    @IBOutlet weak var runLabel: UILabel!
    @IBOutlet weak var situpsLabel: UILabel!
    @IBOutlet weak var pushupsLabel: UILabel!
    @IBOutlet weak var waistLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var minutes: Int?
    var seconds: Int?
    
    /*
     This value is either passed by `FitnessTableViewController` in `prepareForSegue(_:sender:)`
     or constructed as part of adding a new score.
     */
    var score: Score?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set up views if editing an existing Score.
        if let score = score {
            navigationItem.title = "Edit Score"
            let timerMinutes = String(format: "%02d", score.run.minutes)
            let timerSeconds = String(format: "%02d", score.run.seconds)
            
            //concatenate minuets and seconds as assign it to the UILabel
            runLabel.text = timerMinutes + ":" + timerSeconds
            
            situpsLabel.text = score.situps.description
            pushupsLabel.text = score.pushups.description
            waistLabel.text = score.waist.description
        }
        
        // Enable the Save button only if all fields have values.
        checkValidSave()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkValidSave() {
        // Disable the Save button if the text field is empty.
        if runLabel.text == "" || pushupsLabel.text == "" || situpsLabel == "" || waistLabel == "" {
            saveButton.enabled = false
        } else{
            saveButton.enabled = true
        }
    }
    
    //MARK: Navigation
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }

    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let total = 95
            let run = Run(minutes: minutes!, seconds: seconds!)
            let situps = Int(situpsLabel.text!)
            let pushups = Int(pushupsLabel.text!)
            let waist = Double(waistLabel.text!)
            
            // Set the score to be passed to FitnessTableViewController after the unwind segue.
            score = Score(total: total, run: run!, situps: situps!, pushups: pushups!, waist: waist!)
        }
        
    }
    
    @IBAction func unwindForRun(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? RunViewController, run = sourceViewController.runTime {
            // Add a new run time and display for user.
            let timerMinutes = String(format: "%02d", run.minutes)
            let timerSeconds = String(format: "%02d", run.seconds)
            
            //concatenate minuets and seconds as assign it to the UILabel
            runLabel.text = timerMinutes + ":" + timerSeconds
        }
    }
    
    @IBAction func unwindForSitups(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? SitupViewController, situps = sourceViewController.situps {
            // Add a new situps count and display for user.
            situpsLabel.text = situps.description
        }
    }
}