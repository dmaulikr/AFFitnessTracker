//
//  DataMapping.swift
//  AF Fitness Tracker
//
//  Created by Gresko, Anthony (US) on 5/24/16.
//  Copyright © 2016 Tony Gresko. All rights reserved.
//

import Foundation

struct ScoreMapping {
    var runs: [Measurement]?
    var situps: [Measurement]?
    var pushups: [Measurement]?
    var waists: [Measurement]?
}
struct Measurement {
    var measure: Double
    var points: Double
}