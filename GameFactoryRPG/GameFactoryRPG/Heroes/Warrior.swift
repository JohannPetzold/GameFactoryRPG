//
//  Warrior.swift
//  GameFactoryRPG
//
//  Created by Johann Petzold on 24/03/2021.
//

import Foundation

class Warrior: Hero {
    //MARK: Propriétés
    private var diceDamage: Int = 3
    private var baseDamage: Int = 6
    private var diceHeal: Int = 3
    private var baseHeal: Int = 6
    private var weaponType: WeaponType = .sword
    
    //MARK: Init
    override init(name: String) {
        super.init(name: name)
        jobName = Job.warrior.rawValue
        weapon = Weapon(diceDamage: diceDamage, baseDamage: baseDamage, diceHeal: diceHeal, baseHeal: baseHeal, type: weaponType, emoji: weaponType.getWeaponEmoji())
        displayHero()
    }
    
    //MARK: Méthodes
}
