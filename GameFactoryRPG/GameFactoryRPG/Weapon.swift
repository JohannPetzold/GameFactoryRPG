import Foundation

class Weapon {
    //MARK: Propriétés
    var weaponType: WeaponType
    var weaponEmoji: String
    private var diceDamage: Int = 3
    private var baseDamage: Int = 6
    private var diceHeal: Int = 2
    private var baseHeal: Int = 6
    

    //MARK: Init
    init() {
        weaponType = .sword
        weaponEmoji = weaponType.getWeaponEmoji()
    }
    
    init(weaponType: WeaponType) {
        self.weaponType = weaponType
        weaponEmoji = weaponType.getWeaponEmoji()
    }
    
    init(diceDamage: Int, baseDamage: Int, diceHeal: Int, baseHeal: Int, type: WeaponType, emoji: String) {
        self.weaponType = type
        self.weaponEmoji = emoji
        self.diceDamage = diceDamage
        self.baseDamage = baseDamage
        self.diceHeal = diceHeal
        self.baseHeal = baseHeal
    }
    
    //MARK: Méthodes
    /* Génère aléatoirement les dégâts et les soins de l'arme */
    func randomStats() {
        diceDamage = Int.random(in: MIN_DICE_DAMAGE...MAX_DICE_DAMAGE)
        baseDamage = Int.random(in: MIN_DAMAGE...MAX_DAMAGE) * 2
        diceHeal = Int.random(in: MIN_DICE_HEAL...MAX_DICE_HEAL)
        baseHeal = Int.random(in: MIN_HEAL...MAX_HEAL) * 2
    }
    
    /* Modifie les statistiques de l'arme par celles de la nouvelle */
    func changeStats(newWeapon: Weapon) {
        diceDamage = newWeapon.diceDamage
        baseDamage = newWeapon.baseDamage
        diceHeal = newWeapon.diceHeal
        baseHeal = newWeapon.baseHeal
    }
    
    /* Génère les dégâts de manière aléatoire en simulant un jet de dés */
    func randomDamage() -> Int {
        let damage = diceDamage * Int.random(in: 1...baseDamage)
        print("🎲 \(diceDamage)d\(baseDamage) : \(damage) 🎲")
        Thread.sleep(forTimeInterval: 1)
        return damage
    }
    
    /* Génère les soins de manière aléatoire en simulant un jet de dés */
    func randomHeal() -> Int {
        let heal = diceHeal * Int.random(in: 1...baseHeal)
        print("🎲 \(diceHeal)d\(baseHeal) : \(heal) 🎲")
        Thread.sleep(forTimeInterval: 1)
        return heal
    }
    
    /* Renvoi l'affichage des dés d'attaque en String */
    func getDiceDamage() -> String {
        return "\(diceDamage)d\(baseDamage)"
    }
    
    /* Renvoi l'affichage des dés de soin en String */
    func getDiceHeal() -> String {
        return "\(diceHeal)d\(baseHeal)"
    }
}
