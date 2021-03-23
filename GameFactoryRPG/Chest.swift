import Foundation

class Chest {
    //MARK: Propriétés
    var weapon: Weapon
    
    //MARK: Init
    init() {
        weapon = Weapon()
    }
    
    //MARK: Méthodes
    // Gestion de l'apparition du coffre
    func chestAppear() -> Bool {
        var isValid = false
        var answer: String? = nil
        // Définition aléatoire des statistiques de weapon
        weapon.randomStats()
        print("🎁 Un coffre mystérieux apparait 🎁")
        Thread.sleep(forTimeInterval: 1)
        print("Il contient une arme !")
        Thread.sleep(forTimeInterval: 1)
        // Affichage des statistiques de l'arme
        print("* Nouvelle arme : ⚔️  " + weapon.getDiceDamage() + " - 💊 " + weapon.getDiceHeal() + " *")
        Thread.sleep(forTimeInterval: 1)
        print("Souhaitez-vous l'équiper ?")
        print("Oui(y) / Non(n)")
        while !isValid {
            answer = readLine()
            if answer == "y" || answer == "n" {
                isValid = true
                // Retourne true si la valeur entrée correspond au choix positif
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
