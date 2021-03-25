import Foundation

class Weapon {
    //MARK: Propriétés
    private var dice: Int
    private var baseDamage: Int
    private var diceHeal: Int
    private var baseHeal: Int
    var weaponType: WeaponType
    var weaponEmoji: String

    //MARK: Init
    init(job: Job) {
        // Définition des statistiques de base
        switch job {
        case .archer:
            dice = 2
            baseDamage = 8
            diceHeal = 2
            baseHeal = 6
            weaponType = .bow
            weaponEmoji = "🏹"
        case .magician:
            dice = 4
            baseDamage = 4
            diceHeal = 4
            baseHeal = 8
            weaponType = .wand
            weaponEmoji = "⚡️"
        case .warrior:
            dice = 3
            baseDamage = 6
            diceHeal = 3
            baseHeal = 6
            weaponType = .sword
            weaponEmoji = "⚔️"
        }
    }
    
    convenience init() {
        self.init(job: .archer)
    }
    
    //MARK: Méthodes
    // Génère aléatoirement les dégâts et les soins de l'arme
    func randomStats() {
        dice = Int.random(in: MIN_DICE_DAMAGE...MAX_DICE_DAMAGE)
        baseDamage = Int.random(in: MIN_DAMAGE...MAX_DAMAGE) * 2
        diceHeal = Int.random(in: MIN_DICE_HEAL...MAX_DICE_HEAL)
        baseHeal = Int.random(in: MIN_HEAL...MAX_HEAL) * 2
    }
    
    // Modifie les statistiques de l'arme par celles de la nouvelle
    func changeStats(newWeapon: Weapon) {
        dice = newWeapon.dice
        baseDamage = newWeapon.baseDamage
        diceHeal = newWeapon.diceHeal
        baseHeal = newWeapon.baseHeal
    }
    
    // Génère les dégâts de manière aléatoire en simulant un jet de dés
    func randomDamage() -> Int {
        let damage = dice * Int.random(in: 1...baseDamage)
        print("🎲 \(dice)d\(baseDamage) : \(damage) 🎲")
        Thread.sleep(forTimeInterval: 1)
        return damage
    }
    
    // Génère les soins de manière aléatoire en simulant un jet de dés
    func randomHeal() -> Int {
        let heal = diceHeal * Int.random(in: 1...baseHeal)
        print("🎲 \(diceHeal)d\(baseHeal) : \(heal) 🎲")
        Thread.sleep(forTimeInterval: 1)
        return heal
    }
    
    // Renvoi l'affichage du jet de dés en String
    func getDiceDamage() -> String {
        return "\(dice)d\(baseDamage)"
    }
    
    // Renvoi l'affichage du jet de dés en String
    func getDiceHeal() -> String {
        return "\(diceHeal)d\(baseHeal)"
    }
    
    func displayTypeForChest() -> String {
        switch weaponType {
        case .bow: return "un " + weaponType.rawValue
        case .sword: return "une " + weaponType.rawValue
        case .wand: return "un " + weaponType.rawValue
        }
    }
}
