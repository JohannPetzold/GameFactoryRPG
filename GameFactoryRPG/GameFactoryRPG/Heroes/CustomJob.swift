//
//  CustomJob.swift
//  GameFactoryRPG
//
//  Created by Johann Petzold on 26/03/2021.
//

import Foundation

class CustomJob: Hero {
    //MARK: Propriétés
    private var diceDamage: Int = 0
    private var baseDamage: Int = 0
    private var diceHeal: Int = 0
    private var baseHeal: Int = 0
    private var weaponType: WeaponType = .bow
    
    //MARK: Init
    override init(name: String) {
        super.init(name: name)
        jobName = customJobName()
        weaponType = customWeapon()
        customDamage()
        customHeal()
        weapon = Weapon(diceDamage: diceDamage, baseDamage: baseDamage, diceHeal: diceHeal, baseHeal: baseHeal, type: weaponType)
        displayHero()
    }
    
    //MARK: Méthodes
    /* Retourne le nom de la classe entrée par le joueur */
    private func customJobName() -> String {
        var name: String? = nil
        let isValid = false
        print("Choisissez le nom de la classe du Héros :")
        while !isValid {
            name = readLine()
            if name != nil && name != "" {
                return name!
            }
            print("❌ Vous devez entrer un nom de classe ❌")
        }
    }
    
    /* Retourne le type d'arme choisie par le joueur parmi celles existantes */
    private func customWeapon() -> WeaponType {
        var read: String? = nil
        let isValid = false
        var x: Int = 0
        print("Choisissez le type d'arme :")
        for value in WeaponType.allCases {
            x += 1
            print("\(x)) " + value.rawValue)
        }
        while !isValid {
            read = readLine()
            if read != nil {
                if let choice = Int(read!) {
                    if choice > 0 && choice <= x {
                        return WeaponType.allCases[choice - 1]
                    }
                }
            }
            print("❌ Vous devez choisir un chiffre correspondant aux armes listées ❌")
        }
    }
    
    /* Défini le nombre de dés de l'attaque de l'arme, et défini automatiquement les faces des dés */
    private func customDamage() {
        var read: String? = nil
        let isValid = false
        print("Choisissez le nombre de dés pour les dégâts de l'arme :")
        print("Entre \(MIN_DICE_DAMAGE) 🎲 et \(MIN_DICE_DAMAGE + 3) 🎲")
        while !isValid {
            read = readLine()
            if read != nil {
                if let choice = Int(read!) {
                    if choice >= MIN_DICE_DAMAGE && choice <= MIN_DICE_DAMAGE + 3 {
                        self.diceDamage = choice
                        self.baseDamage = MAX_DAMAGE - choice
                        break
                    }
                }
            }
            print("❌ Vous devez choisir un chiffre compris entre \(MIN_DICE_DAMAGE) et \(MIN_DICE_DAMAGE + 3) ❌")
        }
    }
    
    /* Défini le nombre de dés de soins de l'arme, et défini automatiquement les faces des dés */
    private func customHeal() {
        var read: String? = nil
        let isValid = false
        print("Choisissez le nombre de dés pour les soins de l'arme :")
        print("Entre \(MIN_DICE_HEAL) 🎲 et \(MIN_DICE_HEAL + 3) 🎲")
        while !isValid {
            read = readLine()
            if read != nil {
                if let choice = Int(read!) {
                    if choice >= MIN_DICE_HEAL && choice <= MIN_DICE_HEAL + 3 {
                        self.diceHeal = choice
                        self.baseHeal = MAX_HEAL - choice
                        break
                    }
                }
            }
            print("❌ Vous devez choisir un chiffre compris entre \(MIN_DICE_HEAL) et \(MIN_DICE_HEAL + 3) ❌")
        }
    }
}
