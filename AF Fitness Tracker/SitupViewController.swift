//
//  SitupViewController.swift
//  AF Fitness Tracker
//
//  Created by Tony Gresko on 5/3/16.
//  Copyright © 2016 Tony Gresko. All rights reserved.
//

import UIKit

class SitupViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    @IBOutlet weak var situpsInput: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var pausedTime: Int!
    var secondsLeft = 59
    var timerTime = NSTimer()
    var paused: Bool!

    var situps: Int?
    
    lazy var inputToolbar: UIToolbar = {
        var toolbar = UIToolbar()
        toolbar.barStyle = .Default
        toolbar.translucent = true
        toolbar.sizeToFit()
        
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(RunViewController.inputToolbarDonePressed))
        var flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)

        toolbar.setItems([flexibleSpaceButton, doneButton], animated: true)
        toolbar.userInteractionEnabled = true
        
        return toolbar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Handle the text field's user input through delegate callbacks
        self.situpsInput.delegate = self
        
        self.saveButton.enabled = false
        
        self.paused = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.inputAccessoryView == nil {
            textField.inputAccessoryView = inputToolbar
        }
    }
    
    func inputToolbarDonePressed() {
        situpsInput.resignFirstResponder()
    }
    
    let TEXT_FIELD_LIMIT = 3
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string.utf16.count > 0 || textField.text?.utf16.count > 1 {
            self.saveButton.enabled = true
        } else {
            self.saveButton.enabled = false
        }
        return (textField.text?.utf16.count ?? 0) + string.utf16.count - range.length <= TEXT_FIELD_LIMIT
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
                pausedTime = secondsLeft
            } else {
                buttonText = "Start"
            }
        }
        
        if buttonText == "Stop" {
            let aSelector : Selector = #selector(SitupViewController.updateTime)
            timerTime = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSelector, userInfo: nil, repeats: true)
            if self.startStopButton.currentTitle != "Resume" {
                secondsLeft = 59
            }
        }
        
        self.startStopButton.setTitle(buttonText, forState: UIControlState.Normal)
        
        inputToolbarDonePressed()
    }
    
    @IBAction func resetButtonPressed(sender: UIButton) {
        resetTimer()
        inputToolbarDonePressed()
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            situps = Int(situpsInput.text!)
        }
    }
    
    func updateTime() {
        if secondsLeft > 0 {
            secondsLeft = secondsLeft - 1
            
            //add the leading zero for seconds and store them as string constants
            let timerSeconds = String(format: "%02d", secondsLeft)
            
            //concatenate seconds as assign it to the UILabel
            timer.text = "00:" + timerSeconds
        } else {
            resetTimer()
            situpsInput.becomeFirstResponder()
        }
    }
    
    func resetTimer() {
        // Pause display link updates //
        self.paused = true;
        
        // Set default numeric display value //
        self.timer.text = "00:59"
        
        timerTime.invalidate()
        secondsLeft = 59
        
        // Set button to Start state //
        self.startStopButton.setTitle("Start", forState: UIControlState.Normal)
    }
}