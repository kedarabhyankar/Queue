//
//  ProfileTableView.swift
//  Noted
//
//  Created by Kedar Abhyankar on 6/25/20.
//  Copyright © 2020 Kedar Abhyankar. All rights reserved.
//

import UIKit

class ProfileTableView: UITableView, UITableViewDelegate {
    
    
    override func numberOfRows(inSection section: Int) -> Int {
        return 7;
    }
    
    func tableView(_ tableView: UITableView,  forRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! ProfileTableViewCell
        
        let row = indexPath.row
        
        if(row == 0){
            //account configuration
            cell.cellText.text = "Account"
            cell.imageCell = UIImage(systemName: "gear")
            
        } else if(row == 1){
            //notification settings
            cell.cellText.text = "Notifications"
            cell.imageCell = UIImage(systemName: "lightbulb")
            
        } else if(row == 2){
            //location settings
            cell.cellText.text = "Location Awareness"
            cell.imageCell = UIImage(systemName: "location.viewfinder")
            
        } else if(row == 3){
            //data usage
            cell.cellText.text = "Data Usage"
            cell.imageCell = UIImage(systemName: "antenna.radiowaves.left.and.right")
            
        } else if(row == 4){
            //Terms of Use
            cell.cellText.text = "Terms of Use"
            cell.imageCell = UIImage(systemName: "newspaper")
            
        } else if(row == 5){
            //Privacy Policy
            cell.cellText.text = "Privacy Policy"
            cell.imageCell = UIImage(systemName: "lock")
            
        } else {
            //Log out
            cell.cellText.text = "Log Out"
            cell.imageCell = UIImage(systemName: "arrow.left.circle")
        }
        
        return cell;
    }
}
