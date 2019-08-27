//
//  SuggestionDescriptionTableViewCell.swift
//  HavenFirebaseDemo
//
//  Created by Albert Yu on 8/26/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//

import UIKit

class SuggestionDescriptionTableViewCell: UITableViewCell {

//    var hasBeenHidden: Bool = false
    var isCurrentlyHidden: Bool = true
    @IBOutlet weak var decriptionTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
