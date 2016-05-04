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
    var total: Int
    var run: Run
    var situps: Int
    var pushups: Int
    var waist: Double
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("AFFitnessTrackerScores")
    
    // MARK: Types
    struct PropertyKey {
        static let totalKey = "total"
        static let runKey = "run"
        static let situpsKey = "situps"
        static let pushupsKey = "pushups"
        static let waistKey = "waist"
    }
    
    // MARK: Initialization
    init?(total: Int, run: Run, situps: Int, pushups: Int, waist: Double) {
        // Initialize stored properties.
        self.total = total
        self.run = run
        self.situps = situps
        self.pushups = pushups
        self.waist = waist
        
        super.init()
    }
    
    //MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(total, forKey: PropertyKey.totalKey)
        aCoder.encodeObject(run, forKey: PropertyKey.runKey)
        aCoder.encodeInteger(situps, forKey: PropertyKey.situpsKey)
        aCoder.encodeInteger(pushups, forKey: PropertyKey.pushupsKey)
        aCoder.encodeDouble(waist, forKey: PropertyKey.waistKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let total = aDecoder.decodeIntegerForKey(PropertyKey.totalKey)
        let run = aDecoder.decodeObjectForKey(PropertyKey.runKey) as! Run
        let situps = aDecoder.decodeIntegerForKey(PropertyKey.situpsKey)
        let pushups = aDecoder.decodeIntegerForKey(PropertyKey.pushupsKey)
        let waist = aDecoder.decodeDoubleForKey(PropertyKey.waistKey)
        
        // Must call designated initializer.
        self.init(total: total, run: run, situps: situps, pushups: pushups, waist: waist)
    }
}

