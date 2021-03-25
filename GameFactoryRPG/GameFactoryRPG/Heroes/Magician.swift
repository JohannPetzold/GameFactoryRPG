//
//  Magician.swift
//  GameFactoryRPG
//
//  Created by Johann Petzold on 24/03/2021.
//

import Foundation

class Magician: Hero {
    //MARK: Propriétés
    
    
    //MARK: Init
    override init(name: String) {
        super.init(name: name)
        job = .magician
        weapon = Weapon(job: job!)
        displayHero()
    }
    
    //MARK: Méthodes
}
