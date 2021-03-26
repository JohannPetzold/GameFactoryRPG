//
//  Magician.swift
//  GameFactoryRPG
//
//  Created by Johann Petzold on 24/03/2021.
//

import Foundation

class Magician: Hero {
    //MARK: Propriétés
    private var diceDamage: Int = 4
    private var baseDamage: Int = 4
    private var diceHeal: Int = 4
    private var baseHeal: Int = 8
    private var weaponType: WeaponType = .wand
    
    //MARK: Init
    override init(name: String) {
        super.init(name: name)
        jobName = Job.magician.rawValue
        weapon = Weapon(diceDamage: diceDamage, baseDamage: baseDamage, diceHeal: diceHeal, baseHeal: baseHeal, type: weaponType, emoji: weaponType.getWeaponEmoji())
        displayHero()
    }
    
    //MARK: Méthodes
}
