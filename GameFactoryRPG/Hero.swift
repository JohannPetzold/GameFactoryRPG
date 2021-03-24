import Foundation

class Hero {
    //MARK: Propriétés
    var name: String
    var hp: Int
    var weapon: Weapon
    var number: Int
    var totalDamage: Int
    var totalHeal: Int
    var totalDamageReceived: Int
    var totalHealReceived: Int
    
    //MARK: Init
    init(name: String, number: Int) {
        self.name = name
        hp = 100
        weapon = Weapon()
        self.number = number
        totalDamage = 0
        totalHeal = 0
        totalDamageReceived = 0
        totalHealReceived = 0
        displayChampion(onStart: true)
    }
    
    //MARK: Méthodes
    // Change les statistiques de l'armes par celles de la nouvelle
    func swapWeapon(newWeapon: Weapon) {
        weapon.changeStats(newWeapon: newWeapon)
        print(name + " s'équipe de la nouvelle arme")
        displayChampion(onStart: false)
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
        displayChampion(onStart: false)
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
        if hp > 100 {
            hp = 100
        }
        displayChampion(onStart: false)
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
    func displayChampion(onStart: Bool) {
        if onStart {
            let rank = number == 1 ? "Premier" : number == 2 ? "Deuxième" : number == 3 ? "Troisième" : ""
            print("***** " + rank + " Champion *****")
        }
        print(name + " | ", terminator: "")
        displayHp()
        print(" | ⚔️  " + weapon.getDiceDamage(), terminator: "")
        print(" - 💊 " + weapon.getDiceHeal())
    }
    
    // Affichage du Champion à la fin de la partie
    func displayChampionAtEnd() {
        print(name + " | ", terminator: "")
        print("⚔️  " + weapon.getDiceDamage(), terminator: "")
        print(" - 💊 " + weapon.getDiceHeal())
        print("⚔️  Infligés : \(totalDamage)", terminator: "")
        print(" - Reçus : \(totalDamageReceived) ⚔️")
        print("💊 Prodigués : \(totalHeal)", terminator: "")
        print(" - Reçus : \(totalHealReceived) 💊")
    }
    
    // Affichage de la barre de vie
    func displayHp() {
        var count = 0
        print("\(hp)/100 [", terminator: "")
        if hp > 0 {
            while count < 100 {
                count += 10
                if count < hp + 10 {
                    print("🟢", terminator: "")
                } else {
                    print(".", terminator: "")
                }
            }
        } else {
            while count <= 100 {
                print("❌", terminator: "")
                count += 10
            }
        }
        print("]", terminator: "")
    }
}

