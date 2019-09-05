//
//  UserPageButtonsTableViewCell.swift
//  HavenFirebaseDemo
//
//  Created by Albert Yu on 9/4/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import UIKit

class UserPageButtonsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func logOutButtonTapped(_ sender: Any) {
        FirebaseController.shared.signOut()
        //performSegue(withIdentifier: "signOutToOnboardSegue", sender: nil)
    }
    
    @IBAction func joinHomeProfButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func createHomeProfileButtonTapepd(_ sender: Any) {
        
    }
    
}
