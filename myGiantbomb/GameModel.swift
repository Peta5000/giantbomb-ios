//
//  AppModel.swift
//  TopApps
//
//  Created by Peter Sterr on 19.02.15.
//  Copyright (c) 2015 Peter Sterr. All rights reserved.
//

import Foundation

class GameModel: NSObject, Printable {
    let name: String
    let deck: String
    
    override var description: String {
        return "\(name) \nDescription: \(deck)\n\n"
    }
    
    init(name: String?, deck: String?) {
        self.name = name ?? ""
        self.deck = deck ?? ""
    }
}