//
//  WaistViewController.swift
//  AF Fitness Tracker
//
//  Created by Tony Gresko on 5/3/16.
//  Copyright © 2016 Tony Gresko. All rights reserved.
//

import UIKit

class WaistViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var waistInput: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var waist: Double?
    
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
        self.waistInput.delegate = self
        
        //Focus input and show keyboard on load
        waistInput.becomeFirstResponder();
        
        self.saveButton.enabled = false
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
        waistInput.resignFirstResponder()
    }
    
    let TEXT_FIELD_LIMIT = 4
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
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            waist = Double(waistInput.text!)
        }
    }
}