//
//  DataImport.swift
//  AF Fitness Tracker
//
//  Created by Gresko, Anthony (US) on 5/24/16.
//  Copyright © 2016 Tony Gresko. All rights reserved.
//

import Foundation
import SwiftyJSON


func loadInitialData(dataFile: String) -> ScoreMapping {
    let path = NSBundle.mainBundle().pathForResource(dataFile, ofType: "json")!
    let data = NSData(contentsOfFile: path)!
    let json = JSON(data: data)

    var mappings = ScoreMapping(runs: nil, situps: nil, pushups: nil, waists: nil)
    var runs = [Measurement]()
    var situps = [Measurement]()
    var pushups = [Measurement]()
    var waists = [Measurement]()
    for (_, item) in json {
        let runItem = item["run"]
          for (_, item) in runItem {
              let time = item["time"].double!
              let points = item["points"].double!
              runs.append(Measurement(measure: time, points: points))
          }
          let situpItem = item["situps"]
          for (_, item) in situpItem {
              let count = item["count"].double!
              let points = item["points"].double!
              situps.append(Measurement(measure: count, points: points))
          }
          let pushupItem = item["pushups"]
          for (_, item) in pushupItem {
              let count = item["count"].double!
              let points = item["points"].double!
              pushups.append(Measurement(measure: count, points: points))
          }
          let waistItem = item["waist"]
          for (_, item) in waistItem {
              let measurement = item["measurement"].double!
              let points = item["points"].double!
              waists.append(Measurement(measure: measurement, points: points))
          }
        mappings = ScoreMapping(runs: runs, situps: situps, pushups: pushups, waists: waists)
    }

    return mappings
}
