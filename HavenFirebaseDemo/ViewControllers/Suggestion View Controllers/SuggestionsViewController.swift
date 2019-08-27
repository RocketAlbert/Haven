
//
//  SuggestionsViewController.swift
//  HavenFirebaseDemo
//
//  Created by Albert Yu on 8/19/19.
//  Copyright © 2019 DevMountainSquad. All rights reserved.
//



import UIKit

class SuggestionsViewController: UIViewController{
    
    
    var seasonCategoryChosen: [Suggestion]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func suggestionCategoryTapped(_ sender: UIButton) {
        let seasonCategory = sender.currentTitle
        switch seasonCategory {
        case "general":
            seasonCategoryChosen = SuggestionController.shared.general
        case "winter":
            seasonCategoryChosen = SuggestionController.shared.winter
        case "spring":
            seasonCategoryChosen = SuggestionController.shared.spring
        case "fall":
            seasonCategoryChosen = SuggestionController.shared.fall
        case "summer":
            seasonCategoryChosen = SuggestionController.shared.summer
        default:
            print("No way")
        }
        performSegue(withIdentifier: "suggestionsToDetailView", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "suggestionsToDetailView" {
            let destinationVC = segue.destination as? SuggestionsDetailTableViewController
            destinationVC?.seasonsLandingPad = seasonCategoryChosen
        }
    }
    
    
}
