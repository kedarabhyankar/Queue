//
//  ProfileTableViewController.swift
//  Queue
//
//  Created by Kedar Abhyankar on 6/29/20.
//  Copyright © 2020 Kedar Abhyankar. All rights reserved.
//

import UIKit
import FirebaseAuth
import BRYXBanner

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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 0){
            //acount configuration
        } else if(indexPath.row == 1){
            //notifications
            
        } else if(indexPath.row == 2){
            //location
            
        } else if(indexPath.row == 3){
            //data usage
            
        } else if(indexPath.row == 4){
            //tos
            
        } else if(indexPath.row == 5){
            //privacy policy
            
        } else if(indexPath.row == 6){
            //log out
            
            do{
                try Auth.auth().signOut()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "login")
                vc.modalPresentationStyle = .fullScreen
                let banner = Banner(title: "Logged out!", subtitle: "Successfully logged out.", image: nil, backgroundColor: UIColor.green, didTapBlock: nil)
                banner.show(nil, duration: 2)
                UserDefaults.standard.set(false, forKey: "loggedIn")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    self.present(vc, animated: true, completion: nil)
                }
            } catch let error {
                print(error)
            }
            
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
