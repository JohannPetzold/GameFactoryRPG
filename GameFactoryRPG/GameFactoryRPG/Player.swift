// La classe Player gère les actions liées à chaque joueur
class Player {
    //MARK: Propriétés
    var heroes: [Hero] = []
    var alliesAlive: Int = 0
    var totalTurn: Int = 0
    
    //MARK: Init
    /* Création de chaque héros */
    init(allNames: [String]) {
        var listName: [String] = []
        var name: String = ""
        if allNames.count > 0 {
            listName = allNames
        }
        for x in 1...HEROES_NUMBER {
            name = chooseName(x: x, listName: listName)
            chooseJob(name: name)
            alliesAlive += 1
            listName.append(name)
        }
    }
    
    //MARK: Méthodes
    /* Choix du nom du héros et le renvoi en String */
    func chooseName(x: Int, listName: [String]) -> String {
        var name: String? = nil
        let isValid = false
        print("\nChoisissez le nom du Héros \(x) :")
        while !isValid {
            name = readLine()
            if name != nil && !listName.contains(name!) && name != "" {
                return name!
            } else if name == nil || name == "" {
                print("❌ Vous devez entrer un nom ❌")
            } else if listName.contains(name!) {
                print("❌ Le nom choisi existe déjà ❌")
            }
        }
    }
    
    /* Choix de la classe du héros et ajoute le héros à l'array heroes */
    func chooseJob(name: String) {
        let isValid = false
        var read: String? = nil
        
        print("Choisissez la classe du Héros " + name + " :")
        print("1) Archer 🏹\n2) Guerrier ⚔️\n3) Magicien ⚡️\n4) Créer une classe")
        
        while !isValid {
            read = readLine()
            if read != nil {
                if let choice = Int(read!) {
                    if choice > 0 && choice <= Job.allCases.count + 1 {
                        if choice == 1 {
                            heroes.append(Archer(name: name))
                        } else if choice == 2 {
                            heroes.append(Warrior(name: name))
                        } else if choice == 3 {
                            heroes.append(Magician(name: name))
                        } else if choice == 4 {
                            heroes.append(CustomJob(name: name))
                        }
                        break
                    }
                }
            }
            print("❌ Votre choix doit être un chiffre compris entre 1 et 4 ❌")
        }
    }
    
    /* Affichage des héros, choix du héros, retourne l'index correspondant */
    func chooseHeroForAction() -> Int {
        var isValid = false
        var read: String? = nil
        print("----- Choisir le Héros qui va effectuer l'action -----")
        for x in 0...HEROES_NUMBER - 1  {
            if heroes[x].hp <= 0 {
                print("☠️) ", terminator: "")
            } else {
                print("\(x + 1)) ", terminator: "")
            }
            heroes[x].displayHero()
        }
        print("Votre choix (entre 1 et \(HEROES_NUMBER))...")
        while !isValid {
            read = readLine()
            if read != nil {
                if let choice = Int(read!) {
                    if choice > 0 && choice <= HEROES_NUMBER {
                        if heroes[choice - 1].hp <= 0 {
                            print("❌ Le Héros est mort ❌")
                        } else {
                            isValid = true
                            return choice - 1
                        }
                    }
                }
            }
            print("❌ Entrer un chiffre compris entre 1 et \(HEROES_NUMBER) ❌")
        }
    }
    
    /* Choix de l'action, retourne 1 pour attaque et 2 pour soin */
    func chooseAction(hero: Int) -> Int {
        let isValid = false
        var read: String? = nil
        print("\n----- Choisir une action à effectuer -----")
        print("1) " + heroes[hero].weapon.weaponType.getWeaponEmoji() + " Attaquer")
        print("2) 💊 Soigner")
        print("Votre choix (1 ou 2)...")
        while !isValid {
            read = readLine()
            if read != nil {
                if let choice = Int(read!) {
                    if choice == 1 || choice == 2 {
                        return choice
                    }
                }
            }
            print("❌ Vous devez entrer 1 ou 2 ❌")
        }
    }
    
    /* Affichage de la cible en fonction de l'action, choix du héros, retourne son index */
    func chooseTarget(champ: Int, action: Int, ennemy: Player) -> Int {
        let isValid = false
        var read: String? = nil
        var arrayChoice: [Int] = []
        print("\n----- Choisir votre cible -----")
        if action == 1 {
            print("Ennemis")
            arrayChoice = ennemy.displayHeroesTarget()
        } else if action == 2 {
            print("Alliés")
            arrayChoice = displayHeroesTarget()
        }
        print("Votre choix...")
        while !isValid {
            read = readLine()
            if read != nil {
                if let choice = Int(read!) {
                    if arrayChoice.contains(choice) {
                        return choice - 1
                    }
                }
            }
            print("❌ Entrer un chiffre parmi les cibles valides ❌")
        }
    }
    
    func addTurn() {
        totalTurn += 1
    }
    
    /* Vérifie le nombre de héros en vie */
    func checkTeamAlive() {
        var count = 0
        for x in 0...HEROES_NUMBER - 1 {
            if heroes[x].hp > 0 {
                count += 1
            }
        }
        alliesAlive = count
    }
    
    /* Affichage utilisé dans chooseTarget */
    func displayHeroesTarget() -> [Int] {
        var arrayChoice: [Int] = []
        for x in 0...HEROES_NUMBER - 1 {
            if heroes[x].hp <= 0 {
                print("☠️) ", terminator: "")
            } else {
                print("\(x + 1)) ", terminator: "")
                arrayChoice.append(x + 1)
            }
            heroes[x].displayHero()
        }
        return arrayChoice
    }
    
    func displayHeroesAtEnd() {
        for x in 0...HEROES_NUMBER - 1 {
            heroes[x].displayHeroAtEnd()
        }
    }
}
