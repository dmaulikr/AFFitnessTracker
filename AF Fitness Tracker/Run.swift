//
//  Run.swift
//  AF Fitness Tracker
//
//  Created by Tony Gresko on 5/3/16.
//  Copyright © 2016 Tony Gresko. All rights reserved.
//

import UIKit

class Run: NSObject, NSCoding {
    
    // MARK: Properties
    var minutes: Int
    var seconds: Int

    
    // MARK: Types
    struct PropertyKey {
        static let minutesKey = "minutes"
        static let secondsKey = "seconds"
    }
    
    // MARK: Initialization
    init?(minutes: Int, seconds: Int) {
        // Initialize stored properties.
        self.minutes = minutes
        self.seconds = seconds
        
        super.init()
    }
    
    //MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(minutes, forKey: PropertyKey.minutesKey)
        aCoder.encodeInteger(seconds, forKey: PropertyKey.secondsKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let minutes = aDecoder.decodeIntegerForKey(PropertyKey.minutesKey)
        let seconds = aDecoder.decodeIntegerForKey(PropertyKey.secondsKey)
        
        // Must call designated initializer.
        self.init(minutes: minutes, seconds: seconds)
    }
}

