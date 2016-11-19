//
//  SettingsTableViewController.swift
//  FacesterGram
//
//  Created by Ana Ma on 10/27/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    private static let SettingsTableViewCellIdentifier: String = "SettingsTableViewCellIdentifier"
    private static let SliderCellIdentifier: String = "SliderCell"
    private static let SegmentedControlCellIdentifier: String = "SegmentedCell"
    private static let SwitchCellIdentifier: String = "SwitchCell"
    var cellIdentifier = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        switch indexPath.row{
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewController.SliderCellIdentifier, for: indexPath)
            
            if let sliderCell: SliderTableViewCell = cell as? SliderTableViewCell {
                sliderCell.updateSlider(min: SettingsManager.manager.minResults,
                                        max: SettingsManager.manager.maxResults,
                                        current: SettingsManager.manager.results)
                sliderCell.updateSlider(min: 1, max: 200, current: 20)
                sliderCell.delegate = SettingsManager.manager
            }
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: SegmentedTableViewCell.cellIdentifier, for: indexPath)
            if let segmentedCell: SegmentedTableViewCell = cell as? SegmentedTableViewCell {
                segmentedCell.delegate = SettingsManager.manager
            }
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewController.SwitchCellIdentifier, for: indexPath)
        }
        
        // Configure the cell...
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
