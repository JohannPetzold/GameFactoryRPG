//
//  Warrior.swift
//  GameFactoryRPG
//
//  Created by Johann Petzold on 24/03/2021.
//

import Foundation

class Warrior: Hero {
    //MARK: Propriétés
    
    
    //MARK: Init
    override init(name: String) {
        super.init(name: name)
        job = .warrior
        weapon = Weapon(job: job!)
        displayChampion()
    }
    
    //MARK: Méthodes
}
