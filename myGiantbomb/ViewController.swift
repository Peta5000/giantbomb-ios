//
//  ViewController.swift
//  TopApps
//
//  Created by Peter Sterr on 19.02.15.
//  Copyright (c) 2015 Peter Sterr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var searchResults: UITextView!
    @IBAction func search(sender: AnyObject) {
        searchBar.resignFirstResponder()
        DataManager.searchGiantbomb(searchBar.text) {(GBData) -> Void in
            let json = JSON(data: GBData)
            if let gameArray = json["results"].array {
                var games = [GameModel]()
                for gameDict in gameArray {
                    var gameName: String? = gameDict["name"].stringValue
                    var gameDeck: String? = gameDict["deck"].stringValue
                    var game = GameModel(name: gameName, deck: gameDeck)
                    games.append(game)
                }
                println(games)
                dispatch_async(dispatch_get_main_queue(), {
                    var result = ""
                    for game in games {
                        result = result + game.description
                    }
                    if result.isEmpty {
                        self.searchResults.text = "no results available"
                    } else {
                        self.searchResults.text = result
                    }
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

