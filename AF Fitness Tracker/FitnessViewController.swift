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
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var situpsLabel: UILabel!
    @IBOutlet weak var pushupsLabel: UILabel!
    @IBOutlet weak var waistLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is either passed by `MealTableViewController` in `prepareForSegue(_:sender:)`
     or constructed as part of adding a new meal.
     */
    var score: Score?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let score = score {
            //navigationItem.title = score.total
            runTimeLabel.text = score.run.description
            situpsLabel.text = score.situps.description
            pushupsLabel.text = score.pushups.description
            waistLabel.text = score.waist.description
        }
        
        checkValidSave()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkValidSave() {
        // Disable the Save button if the text field is empty.
        if runTimeLabel.text == "" || pushupsLabel.text == "" || situpsLabel == "" || waistLabel == "" {
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
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        /*if saveButton === sender {
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            let rating = ratingControl.rating
            
            // Set the meal to be passed to MealTableViewController after the unwind segue.
            meal = Meal(name: name, photo: photo, rating: rating)
        }*/
    }*/

}

