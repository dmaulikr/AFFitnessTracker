//
//  RunViewController.swift
//  AF Fitness Tracker
//
//  Created by Gresko, Anthony (US) on 4/27/16.
//  Copyright © 2016 Tony Gresko. All rights reserved.
//

import UIKit
import QuartzCore

class RunViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    @IBOutlet weak var minutes: UITextField!
    @IBOutlet weak var seconds: UITextField!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var startTime = NSTimeInterval()
    var pausedTime = NSTimeInterval()
    var timerMinutes: String!
    var timerSeconds: String!
    var timerTime = NSTimer()
    var paused: Bool!
    
    var runTime: Run?
    
    lazy var inputToolbar: UIToolbar = {
        var toolbar = UIToolbar()
        toolbar.barStyle = .Default
        toolbar.translucent = true
        toolbar.sizeToFit()
        
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(RunViewController.inputToolbarDonePressed))
        var flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        var fixedSpaceButton = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        var nextButton  = UIBarButtonItem(image: UIImage(named: "ForwardKeyboardNav"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(RunViewController.keyboardNextButton))
        nextButton.width = 50.0
        var previousButton  = UIBarButtonItem(image: UIImage(named: "BackKeyboardNav"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(RunViewController.keyboardPreviousButton))
        
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
        
        //minutes.becomeFirstResponder()

        // Ensure that the display link is initially not updating //
        self.paused = true;
        
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
        }
        
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    let TEXT_FIELD_LIMIT = 2
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return (textField.text?.utf16.count ?? 0) + string.utf16.count - range.length <= TEXT_FIELD_LIMIT
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

    @IBAction func startStopButtonPressed(sender: UIButton) {
        // Toggle the paused boolean value //
        self.paused = !(self.paused)
        
        // if the display link is not updating us... //
        var buttonText:String = "Stop"
        if self.paused! {
            timerTime.invalidate()
            if self.timerTime.timeInterval > 0 {
                buttonText = "Resume"
                pausedTime = NSDate.timeIntervalSinceReferenceDate() - startTime
                minutes.text = timerMinutes
                seconds.text = timerSeconds
                saveButton.enabled = true
            } else {
                buttonText = "Start"
            }
        }
        
        if buttonText == "Stop" {
            let aSelector : Selector = #selector(RunViewController.updateTime)
            timerTime = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            if self.startStopButton.currentTitle != "Resume" {
                startTime = NSDate.timeIntervalSinceReferenceDate()
            } else {
                startTime = NSDate.timeIntervalSinceReferenceDate() - self.pausedTime
            }
        }
        
        self.startStopButton.setTitle(buttonText, forState: UIControlState.Normal)
    }
    
    @IBAction func resetButtonPressed(sender: UIButton) {
        // Pause display link updates //
        self.paused = true;
        
        // Set default numeric display value //
        self.timer.text = "00:00"
        
        timerTime.invalidate()
        startTime = NSDate.timeIntervalSinceReferenceDate()
        
        // Set button to Start state //
        self.startStopButton.setTitle("Start", forState: UIControlState.Normal)
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            if minutes.text == "" {
                minutes.text = "0"
            }
            if seconds.text == "" {
                seconds.text = "0"
            }
            
            let total = (Int(minutes.text!)! * 60) + Int(seconds.text!)!
            // Set the run time to be passed to FitnessViewController after the unwind segue.
            if total > 0 {
                runTime = Run(minutes: Int(minutes.text!)!, seconds: Int(seconds.text!)!)
            }
        }
    }
    
    func checkValidRunTime() {
        // Disable the Save button if the text field is empty.
        //check if minutes can be casted to int
        
        //check if seconds can be casted to int
        if (minutes.text == "" && seconds.text == "") || minutes.text! == "" || Int(seconds.text!) > 59 {
            saveButton.enabled = false
        } else{
            saveButton.enabled = true
        }
    }
    
    func updateTime() {
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        timerMinutes = String(format: "%02d", minutes)
        timerSeconds = String(format: "%02d", seconds)
        
        //concatenate minuets and seconds as assign it to the UILabel
        timer.text = timerMinutes + ":" + timerSeconds
        
    }
}