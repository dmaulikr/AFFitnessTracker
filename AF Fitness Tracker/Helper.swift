//
//  Helper.swift
//  AF Fitness Tracker
//
//  Created by Tony Gresko on 4/27/16.
//  Copyright © 2016 Tony Gresko. All rights reserved.
//

import Foundation
import UIKit

struct Helper {
    static func createAccessoryViewWithTarget(target: AnyObject, width: CGFloat) -> UIView {
        let accessoryView = UIView(frame: CGRectMake(0, 0, width, 40))
        //accessoryView.backgroundColor = UIColor.lightGrayColor()//UIColor(red: 68/255.0, green: 68/255.0, blue: 68/255.0, alpha: 1.0)
        
        let closeLabel = UILabel(frame: accessoryView.frame)
        closeLabel.font = UIFont.boldSystemFontOfSize(14.0)
        closeLabel.text = "Close"
        closeLabel.textColor = UIColor.blueColor()
        closeLabel.textAlignment = NSTextAlignment.Right
        accessoryView.addSubview(closeLabel)
        
        let nextLabel = UILabel(frame: accessoryView.frame)
        nextLabel.font = UIFont.boldSystemFontOfSize(14.0)
        nextLabel.text = "Next"
        nextLabel.textColor = UIColor.blueColor()
        nextLabel.textAlignment = NSTextAlignment.Left
        accessoryView.addSubview(nextLabel)

        
        let closeButton = UIButton(frame: accessoryView.frame)
        /*closeButton.addTarget(target, action: #selector(RunViewController.dismissKeyboard), forControlEvents: UIControlEvents.TouchUpInside)*/
        accessoryView.addSubview(closeButton)
        
        let nextButton = UIButton(frame: accessoryView.frame)
        /*nextButton.addTarget(target, action: #selector(RunViewController.nextInput), forControlEvents: UIControlEvents.TouchUpInside)*/
        accessoryView.addSubview(nextButton)
        
        accessoryView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        closeLabel.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        closeButton.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        nextLabel.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        nextButton.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        
        return accessoryView
    }
}