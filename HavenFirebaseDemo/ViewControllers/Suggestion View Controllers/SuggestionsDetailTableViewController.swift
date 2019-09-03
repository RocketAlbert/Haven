//
//  SuggestionsDetailTableViewController.swift
//  HavenFirebaseDemo
//
//  Created by Albert Yu on 8/22/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//


// TableViews execute in the following order. This code was created in order to avoid keeping track of cells in data, majing
// 1. DidSelect
// 2. CellForRowAt
// 3. HeightForRowAt

import UIKit

class SuggestionsDetailTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var seasonsLandingPad: [Suggestion]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        tableView.allowsSelection = true
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let seasonSuggestions = seasonsLandingPad else {return 0}
        return seasonSuggestions.count * 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
            // 45 seems to be the height that works best.
            return 45.0
        }
        
        // Checks is cell is open and adjusts the height accordingly.
        guard let cell = tableView.cellForRow(at: indexPath) as? SuggestionDescriptionTableViewCell else {return 0.0}
        print(indexPath.row)
        if cell.isCurrentlyHidden == true {
            return 0
        } else {
            return 50.0
        }
    }

    // Analysis: a new cell is created each time and there is no memory in the new cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "suggestionCell", for: indexPath) as? SuggestionCellTableViewCell else {return UITableViewCell ()}
            let seasonSuggestion = seasonsLandingPad?[indexPath.row/2]
            cell.suggestionLabel.text = seasonSuggestion?.name
            return cell
        }
        
        // We establish an isCurrent variable to keep track of the previous state.
        var isCurrent = true
        if let cellBefore = tableView.cellForRow(at: indexPath) as? SuggestionDescriptionTableViewCell {
            isCurrent = cellBefore.isCurrentlyHidden

        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "suggestionDescriptionCell", for: indexPath) as? SuggestionDescriptionTableViewCell else {return UITableViewCell ()}
        let seasonSuggestion = seasonsLandingPad?[(indexPath.row - 1)/2]
        cell.isHidden = isCurrent
        // Because there this is a new cell, we must reiterate what was in the previous state.
        cell.isCurrentlyHidden = isCurrent
        cell.decriptionTextView.text = seasonSuggestion?.description
        cell.isUserInteractionEnabled = false
        return cell
    }
    
    // The change to isCurrentlyHidden is noted, before this function calls the reload, running through the cellForRow at function.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let nextIndexPath:NSIndexPath = NSIndexPath(row: indexPath.row + 1, section: indexPath.section)
        guard let cellToOpen = tableView.cellForRow(at: nextIndexPath as IndexPath) as? SuggestionDescriptionTableViewCell else {return}
        cellToOpen.isCurrentlyHidden = !cellToOpen.isCurrentlyHidden
        self.tableView.reloadRows(at: [nextIndexPath as IndexPath], with: .none)
    }
}
