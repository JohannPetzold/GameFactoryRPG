//
//  Archer.swift
//  GameFactoryRPG
//
//  Created by Johann Petzold on 24/03/2021.
//

import Foundation

class Archer: Hero {
    //MARK: Propriétés
    
    
    //MARK: Init
    override init(name: String) {
        super.init(name: name)
        job = .archer
        weapon = Weapon(job: job!)
        displayHero()
    }
    
    //MARK: Méthodes
}
