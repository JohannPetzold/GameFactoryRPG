//
//  Archer.swift
//  GameFactoryRPG
//
//  Created by Johann Petzold on 24/03/2021.
//

import Foundation

class Archer: Hero {
    //MARK: Propriétés
    private var diceDamage: Int = 2
    private var baseDamage: Int = 8
    private var diceHeal: Int = 2
    private var baseHeal: Int = 6
    private var weaponType: WeaponType = .bow
    
    //MARK: Init
    override init(name: String) {
        super.init(name: name)
        jobName = Job.archer.rawValue
        weapon = Weapon(diceDamage: diceDamage, baseDamage: baseDamage, diceHeal: diceHeal, baseHeal: baseHeal, type: weaponType, emoji: weaponType.getWeaponEmoji())
        displayHero()
    }
    
    //MARK: Méthodes
}
