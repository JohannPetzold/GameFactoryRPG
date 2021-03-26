import Foundation

class Chest {
    //MARK: Propriétés
    var weapon: Weapon
    
    //MARK: Init
    init(weaponType: WeaponType) {
        weapon = Weapon(weaponType: weaponType)
    }
    
    //MARK: Méthodes
    // Gestion de l'apparition du coffre
    func chestAppear() -> Bool {
        var isValid = false
        var answer: String? = nil
        // Définition aléatoire des statistiques de weapon
        //TODO: Voir pour générer une arme aléatoire
        weapon.randomStats()
        print("🎁 Un coffre mystérieux apparait 🎁")
        Thread.sleep(forTimeInterval: 1)
        print("Il contient une arme ! C'est " + weapon.weaponType.displayTypeForChest() + " !")
        Thread.sleep(forTimeInterval: 1)
        print("* Nouvelle arme : " + weapon.weaponEmoji + " " + weapon.getDiceDamage() + " - 💊 " + weapon.getDiceHeal() + " *")
        Thread.sleep(forTimeInterval: 1)
        print("Souhaitez-vous l'équiper ?")
        print("Oui(y) / Non(n)")
        while !isValid {
            answer = readLine()
            if answer == "y" || answer == "n" {
                isValid = true
                if answer == "y" {
                    return true
                } else if answer == "n" {
                    return false
                }
            } else {
                print("❌ Votre choix ? (y/n) ❌")
            }
        }
        return false
    }
}
