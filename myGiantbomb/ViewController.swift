//
//  ViewController.swift
//  TopApps
//
//  Created by Peter Sterr on 19.02.15.
//  Copyright (c) 2015 Peter Sterr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.searchGiantbomb { (GBData) -> Void in
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
            }
        }
    }
}

