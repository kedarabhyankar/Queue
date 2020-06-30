//
//  ProfileTableViewController.swift
//  Noted
//
//  Created by Kedar Abhyankar on 6/29/20.
//  Copyright © 2020 Kedar Abhyankar. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! ProfileTableViewCell
        let row = indexPath.row
        
        if(row == 0){
            //account configuration
            cell.cellText.text = "Account"
            cell.imageCell.image = UIImage(systemName: "gear")
            
        } else if(row == 1){
            //notification settings
            cell.cellText.text = "Notifications"
            cell.imageCell.image = UIImage(systemName: "lightbulb")
        } else if(row == 2){
            //location settings
            cell.cellText.text = "Location Awareness"
            cell.imageCell.image = UIImage(systemName: "location.viewfinder")
            
        } else if(row == 3){
            //data usage
            cell.cellText.text = "Data Usage"
            cell.imageCell.image = UIImage(systemName: "antenna.radiowaves.left.and.right")
            
        } else if(row == 4){
            //Terms of Use
            cell.cellText.text = "Terms of Use"
            cell.imageCell.image = UIImage(systemName: "newspaper")
            
        } else if(row == 5){
            //Privacy Policy
            cell.cellText.text = "Privacy Policy"
            cell.imageCell.image = UIImage(systemName: "lock")
            
        } else {
            //Log out
            cell.cellText.text = "Log Out"
            cell.imageCell.image = UIImage(systemName: "arrow.left.circle")
        }
        
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
