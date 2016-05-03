//
//  FitnessTableViewController.swift
//  AF Fitness Tracker
//
//  Created by Tony Gresko on 4/26/16.
//  Copyright © 2016 Tony Gresko. All rights reserved.
//

import UIKit

class FitnessTableViewController: UITableViewController {
    
    // MARK: Properties
    var scores = [Score]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load any saved scores, otherwise load sample data.
        if let savedScores = loadFitnessScores() {
            scores += savedScores
        }
        else{
            // Load the sample data.
            loadSampleScores()
        }
    }
    
    func loadSampleScores() {
        let score1 = Score(total: 80, run: 570, situps: 40, pushups: 55, waist: 34.5)!
        
        let score2 = Score(total: 78, run: 615, situps: 38, pushups: 50, waist: 34.5)!
        
        let score3 = Score(total: 93, run: 523, situps: 56, pushups: 65, waist: 34)!
        
        scores += [score1, score2, score3]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scores.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "FitnessTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! FitnessTableViewCell
        
        // Fetches the appropriate score for the data source layout.
        let score = scores[indexPath.row]
        
        cell.totalLabel.text = score.total.description
        cell.runTimeLabel.text = score.run.description
        cell.waistLabel.text = score.waist.description
        cell.situpsLabel.text = score.situps.description
        cell.pushupsLabel.text = score.pushups.description
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            scores.removeAtIndex(indexPath.row)
            saveScores()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let fitnessDetailViewController = segue.destinationViewController as! FitnessViewController
            
            // Get the cell that generated this segue.
            if let selectedScoreCell = sender as? FitnessTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedScoreCell)!
                let selectedScore = scores[indexPath.row]
                fitnessDetailViewController.score = selectedScore
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new score.")
        }
    }
    
    
    @IBAction func unwindToScoreList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? FitnessViewController, score = sourceViewController.score {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                // Update an existing score.
                scores[selectedIndexPath.row] = score
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else {
                // Add a new score.
                let newIndexPath = NSIndexPath(forRow: scores.count, inSection: 0)
                scores.append(score)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
        }
        
        // Save the score.
        saveScores()
    }
    
    // MARK: NSCoding
    func saveScores() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(scores, toFile: Score.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed to save scores...")
        }
    }
    
    func loadFitnessScores() -> [Score]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Score.ArchiveURL.path!) as? [Score]
    }
}
