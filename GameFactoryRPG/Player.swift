// La classe Player gère les actions liées à chaque joueur
class Player {
    //MARK: Propriétés
    var heroes: [Hero] = []
    var alliesAlive: Int = 0
    var totalTurn: Int = 0
    
    //MARK: Init
    init(allNames: [String]) {
        // L'init va permettre le choix du nom de chaque Champion
        var listName: [String] = []
        if allNames.count > 0 {
            listName = allNames
        }
        for x in 1...3 {
            var name: String? = nil
            var isValid = false
            let rank = x == 1 ? "premier" : x == 2 ? "deuxième" : x == 3 ? "troisième" : ""
            print("\nChoisissez le nom du " + rank + " Champion : ")
            while !isValid {
                // Écoute ce que l'utilisateur entre
                name = readLine()
                // Si name existe, qu'il est différent d'une string vide et qu'il n'est pas déjà existant dans listName
                if name != nil && !listName.contains(name!) && name != "" {
                    heroes.append(Hero(name: name!, number: x))
                    alliesAlive += 1
                    listName.append(name!)
                    isValid = true
                // Sinon si name est nil ou est vide
                } else if name == nil || name == "" {
                    print("❌ Vous devez entrer un nom ❌")
                // Ou s'il existe dans listName
                } else if listName.contains(name!) {
                    print("❌ Le nom choisi existe déjà ❌")
                }
            }
        }
    }
    
    //MARK: Méthodes
    // Choix du Champion qui va effectuer l'action
    func chooseChampForAction() -> Int {
        var isValid = false
        print("----- Choisir le champion qui va effectuer l'action -----")
        // Affichage des Champions
        for x in 0...2 {
            // Si le Champion est mort
            if heroes[x].hp <= 0 {
                print("❌) ", terminator: "")
            } else {
                print("\(x + 1)) ", terminator: "")
            }
            heroes[x].displayChampion(onStart: false)
        }
        print("Votre choix (entre 1 et 3)...")
        while !isValid {
            // Si la valeur entrée peut être convertie en Int
            if let choice = Int(readLine()!) {
                // Si la valeur est un chiffre entre 1 et 3
                if choice > 0 && choice < 4 {
                    // Vérifie si le Champion est mort
                    if heroes[choice - 1].hp <= 0 {
                        print("❌ Le champion est mort ❌")
                    // S'il est en vie, retourne le choix - 1 pour avoir l'index
                    } else {
                        isValid = true
                        return choice - 1
                    }
                // Message d'erreur si le chiffre est inférieur ou supérieur
                } else {
                    print("❌ Votre choix doit être compris entre 1 et 3 ❌")
                }
            // Message d'erreur si la valeur d'entrée n'est pas un chiffre
            } else {
                print("❌ Entrer un chiffre compris entre 1 et 3 ❌")
            }
        }
    }
    
    // Choix de l'action qui va être effectuée
    func chooseAction() -> Int {
        var isValid = false
        print("\n----- Choisir une action à effectuer -----")
        print("1) ⚔️  Attaquer")
        print("2) 💊 Soigner")
        print("Votre choix (1 ou 2)...")
        while !isValid {
            // Si la valeur d'entrée peut être convertie en Int
            if let choice = Int(readLine()!) {
                // Si la valeur est 1 ou 2, retourne le choix
                if choice == 1 || choice == 2 {
                    isValid = true
                    return choice
                }
            }
            // Le message d'erreur s'affiche forcément si la valeur d'entrée n'est pas bonne
            print("❌ Vous devez entrer 1 ou 2 ❌")
        }
    }
    
    // Choix de la cible de l'action
    func chooseTarget(champ: Int, action: Int, ennemy: Player) -> Int {
        var isValid = false
        var arrayChoice: [Int] = []
        print("\n----- Choisir votre cible -----")
        // Si l'action est attaquer
        if action == 1 {
            print("Ennemis")
            // Affichage des ennemis
            for x in 0...2 {
                // Si le Champion est mort
                if ennemy.heroes[x].hp <= 0 {
                    print("❌) ", terminator: "")
                // Sinon ajoute la valeur à arrayChoice
                } else {
                    print("\(x + 1)) ", terminator: "")
                    arrayChoice.append(x + 1)
                }
                ennemy.heroes[x].displayChampion(onStart: false)
            }
        // Si l'action est soigner
        } else if action == 2 {
            print("Alliés")
            // Affichage des alliés
            for x in 0...2 {
                // Si le Champion est mort
                if heroes[x].hp <= 0 {
                    print("❌) ", terminator: "")
                // Sinon ajoute la valeur à arrayChoice
                } else {
                    print("\(x + 1)) ", terminator: "")
                    arrayChoice.append(x + 1)
                }
                heroes[x].displayChampion(onStart: false)
            }
        }
        print("Votre choix...")
        while !isValid {
            // Si la valeur d'entrée peut être convertie en Int
            if let choice = Int(readLine()!) {
                // Si arrayChoice contient la valeur entrée
                if arrayChoice.contains(choice) {
                    isValid = true
                    return choice - 1
                // Message d'erreur si la valeur entrée n'est pas dans arrayChoice
                } else {
                    print("❌ Choisir une cible valide ❌")
                }
            // Message d'erreur si la valeur entrée n'est pas un chiffre
            } else {
                print("❌ Entrer un chiffre parmi les cibles valides ❌")
            }
        }
    }
    
    // Incrémente le total des tours du joueur
    func addTurn() {
        totalTurn += 1
    }
    
    // Vérification du nombre de Champions en vies
    func checkTeamAlive() {
        var count = 0
        for x in 0...2 {
            if heroes[x].hp > 0 {
                count += 1
            }
        }
        alliesAlive = count
    }
}
