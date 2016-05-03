//
//  RunViewController.swift
//  AF Fitness Tracker
//
//  Created by Gresko, Anthony (US) on 4/27/16.
//  Copyright © 2016 Tony Gresko. All rights reserved.
//

import UIKit

class RunViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    @IBOutlet weak var minutes: UITextField!
    @IBOutlet weak var seconds: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var runTime: Double?
    
    lazy var inputToolbar: UIToolbar = {
        var toolbar = UIToolbar()
        toolbar.barStyle = .Default
        toolbar.translucent = true
        toolbar.sizeToFit()
        
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(RunViewController.inputToolbarDonePressed))
        var flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        var fixedSpaceButton = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        //image: UIImage(named: "keyboardPreviousButton")
        var nextButton  = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(RunViewController.keyboardNextButton))
        nextButton.width = 50.0
        //image: UIImage(named: "keyboardNextButton")
        var previousButton  = UIBarButtonItem(title: "Previous", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(RunViewController.keyboardPreviousButton))
        
        toolbar.setItems([fixedSpaceButton, previousButton, fixedSpaceButton, nextButton, flexibleSpaceButton, doneButton], animated: true)
        toolbar.userInteractionEnabled = true
        
        return toolbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Handle the text field's user input through delegate callbacks
        minutes.delegate = self
        seconds.delegate = self
        
        minutes.becomeFirstResponder()
        
        checkValidRunTime()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        
        if textField == minutes { // Switch focus to other text field
            seconds.becomeFirstResponder()
        }else if textField == seconds {
            seconds.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidRunTime()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.inputAccessoryView == nil {
            textField.inputAccessoryView = inputToolbar
            //textField.inputAccessoryView =  Helper.createAccessoryViewWithTarget(self, width: self.view.frame.width/2)
        }
        
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func inputToolbarDonePressed() {
        minutes.resignFirstResponder()
        seconds.resignFirstResponder()
    }
    
    func keyboardNextButton() {
        minutes.resignFirstResponder()
        seconds.becomeFirstResponder()
    }
    
    func keyboardPreviousButton() {
        minutes.becomeFirstResponder()
        seconds.resignFirstResponder()
    }
    
    //MARK: Navigation
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddRunMode = presentingViewController is UINavigationController
        
        if isPresentingInAddRunMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }

    }

    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Preparing...")
        if saveButton === sender {
            
            let total = (Int(minutes.text!)! * 60) + Int(seconds.text!)!
            // Set the run time to be passed to FitnessViewController after the unwind segue.
            runTime = Double(total)
        }
    }
    
    func checkValidRunTime() {
        // Disable the Save button if the text field is empty.
        //check if minutes can be casted to int
        
        //check if seconds can be casted to int
        if minutes.text == "00" || seconds.text == "00" {
            //saveButton.enabled = false
        } else{
            saveButton.enabled = true
        }
    }
}