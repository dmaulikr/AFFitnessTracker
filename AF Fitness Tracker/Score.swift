//
//  Fitness.swift
//  AF Fitness Tracker
//
//  Created by Tony Gresko on 4/26/16.
//  Copyright © 2016 Tony Gresko. All rights reserved.
//

import UIKit

class Score: NSObject, NSCoding {
    
    // MARK: Properties
    var run: NSTimeInterval
    var situps: Int
    var pushups: Int
    var waist: Double
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("fitness")
    
    // MARK: Types
    struct PropertyKey {
        static let runKey = "run"
        static let situpsKey = "situps"
        static let pushupsKey = "pushups"
        static let waistKey = "waist"
    }
    
    // MARK: Initialization
    init?(run: NSTimeInterval, situps: Int, pushups: Int, waist: Double) {
        // Initialize stored properties.
        self.run = run
        self.situps = situps
        self.pushups = pushups
        self.waist = waist
        
        super.init()
    }
    
    //MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(run, forKey: PropertyKey.runKey)
        aCoder.encodeObject(situps, forKey: PropertyKey.situpsKey)
        aCoder.encodeInteger(pushups, forKey: PropertyKey.pushupsKey)
        aCoder.encodeDouble(waist, forKey: PropertyKey.waistKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let run = aDecoder.decodeObjectForKey(PropertyKey.runKey) as! NSTimeInterval
        let situps = aDecoder.decodeIntegerForKey(PropertyKey.situpsKey)
        let pushups = aDecoder.decodeIntegerForKey(PropertyKey.pushupsKey)
        let waist = aDecoder.decodeDoubleForKey(PropertyKey.waistKey)
        
        // Must call designated initializer.
        self.init(run: run, situps: situps, pushups: pushups, waist: waist)
    }
}

