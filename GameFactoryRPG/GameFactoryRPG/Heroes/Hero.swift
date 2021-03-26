import Foundation

class Hero {
    //MARK: Propriétés
    var name: String
    var hp: Int
    // A modifier
    var weapon: Weapon
    var jobName: String
    var totalDamage: Int
    var totalHeal: Int
    var totalDamageReceived: Int
    var totalHealReceived: Int
    
    //MARK: Init
    init(name: String) {
        self.name = name
        hp = HP_MAX
        weapon = Weapon()
        jobName = ""
        totalDamage = 0
        totalHeal = 0
        totalDamageReceived = 0
        totalHealReceived = 0
    }
    
    //MARK: Méthodes
    // Change les statistiques de l'armes par celles de la nouvelle
    func swapWeapon(newWeapon: Weapon) {
        weapon.changeStats(newWeapon: newWeapon)
        print(name + " s'équipe de la nouvelle arme")
        displayHero()
        Thread.sleep(forTimeInterval: 1)
    }
    
    // Réception du montant de dégâts
    func getDamage(damage: Int) {
        print(name + " prend \(damage) dégâts")
        // Ajout du montant aux statistiques
        totalDamageReceived += damage
        Thread.sleep(forTimeInterval: 1)
        // Diminution des points de vie
        hp = hp - damage
        // Si les dégâts descendent les points de vie à 0 ou en dessous
        if hp <= 0 {
            print(name + " est mort ☠️")
            hp = 0
        }
        displayHero()
        Thread.sleep(forTimeInterval: 1)
    }
    
    // Réception du montant du soin
    func getHeal(heal: Int) {
        print(name + " regagne \(heal) points de vie")
        // Ajout du montant aux statistiques
        totalHealReceived += heal
        Thread.sleep(forTimeInterval: 1)
        // Ajout des points de vie
        hp += heal
        // Si le montant augmente les points de vie au-dessus du montant maximum
        if hp > HP_MAX {
            hp = HP_MAX
        }
        displayHero()
        Thread.sleep(forTimeInterval: 1)
    }
    
    // Ajoute le montant des dégâts aux statistiques
    func addTotalDamage(_ damage: Int) {
        totalDamage += damage
    }
    
    // Ajout le montant des soins aux statistiques
    func addTotalHeal(_ heal: Int) {
        totalHeal += heal
    }
    
    // Affichage du Champion
    func displayHero() {
        displayName()
        displayHp()
        print(" | " + weapon.weaponEmoji + " " + weapon.getDiceDamage(), terminator: "")
        print(" - 💊 " + weapon.getDiceHeal())
    }
    
    // Affichage du Champion à la fin de la partie
    func displayHeroAtEnd() {
        displayName()
        print(weapon.weaponEmoji + " " + weapon.getDiceDamage(), terminator: "")
        print(" - 💊 " + weapon.getDiceHeal())
        print(weapon.weaponEmoji + " Dégâts " + weapon.weaponEmoji + " ", terminator: "")
        print("Infligés : \(totalDamage) - Reçus : \(totalDamageReceived)")
        print("💊 Soins 💊 Prodigués : \(totalHeal) - Reçus : \(totalHealReceived)")
    }
    
    private func displayName() {
        print(name + " | " + jobName + " | ", terminator: "")
    }
    
    // Affichage de la barre de vie
    private func displayHp() {
        var count = 0
        print("\(hp)/\(HP_MAX) [", terminator: "")
        if hp > 0 {
            while count < HP_MAX {
                count += HP_MAX / 10
                if count < hp + (HP_MAX / 10) {
                    if hp <= HP_MAX.getPercentage(20) {
                        print("🔴", terminator: "")
                    } else if hp <= HP_MAX.getPercentage(40) {
                        print("🟠", terminator: "")
                    } else if hp <= HP_MAX.getPercentage(60) {
                        print("🟡", terminator: "")
                    } else {
                        print("🟢", terminator: "")
                    }
                } else {
                    print("⚪️", terminator: "")
                }
            }
        } else {
            while count <= HP_MAX {
                print("⚫️", terminator: "")
                count += (HP_MAX / 10)
            }
        }
        print("]", terminator: "")
    }
}

