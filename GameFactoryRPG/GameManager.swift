import Foundation

// La classe GameManager permet de gérer les différentes phases du jeu
class GameManager {
    //MARK: Propriétés
    var players: [Player]
    var allNames: [String]
    var isEnd: Bool
    var playerTurn: Int
    var chest: Chest?
    var endGame: Bool
    
    //MARK: Init
    init() {
        players = []
        allNames = []
        isEnd = false
        playerTurn = 0
        endGame = false
    }
    
    //MARK: Méthodes
    // Affiche le titre du jeu
    func startGame() {
        print("⚔️ ⚔️ ⚔️ Bienvenue dans GameFactoryRPG ⚔️ ⚔️ ⚔️\n")
        Thread.sleep(forTimeInterval: 1)
    }
    
    // Choix des personnages et de leur nom
    func chooseCharacters() {
        print("Entrer les informations du Joueur 1")
        // Ajout d'une instance de Player
        players.append(Player(allNames: allNames))
        // Stockage des noms du premier Player
        getTeamNames(players[0])
        print("\nEntrer les informations du Joueur 2")
        // Ajout d'une instance de Player
        players.append(Player(allNames: allNames))
        print("\nLa partie peut commencer !")
        Thread.sleep(forTimeInterval: 1)
    }
    
    // Stock les noms pour éviter les doublons
    func getTeamNames(_ player: Player) {
        if player.heroes.count == 3 {
            for x in 0...2 {
                allNames.append(player.heroes[x].name)
            }
        }
    }
    
    // Choix du joueur qui débute la partie via un random
    func getPlayerTurn() {
        print("Choix du joueur qui va commencer...")
        // Définition du joueur qui commence via un random
        // Le range du random est le nombre de joueur - 1
        playerTurn = Int.random(in: 0...players.count - 1)
        Thread.sleep(forTimeInterval: 1)
        print("C'est le Joueur \(playerTurn + 1) qui commence\n")
        Thread.sleep(forTimeInterval: 1)
    }
    
    // La loop du jeu avec le tour de chaque joueur
    func gameLoop() {
        // Boucle tant que la variable est false
        while !endGame {
            print("---------- Joueur \(playerTurn + 1) ----------")
            // Choix du personnage qui attaque
            let hero = players[playerTurn].chooseChampForAction()
            // Apparition aléatoire du coffre
            let spawnChest = Int.random(in: 1...RATE_CHEST)
            if spawnChest == 1 {
                chest = Chest(job: players[playerTurn].heroes[hero].job!)
                // Si le joueur décide de prendre la nouvelle arme
                if chest!.chestAppear() {
                    // Modification de son arme actuelle
                    players[playerTurn].heroes[hero].swapWeapon(newWeapon: chest!.weapon)
                }
            }
            // Choix de l'action
            let actionChoice = players[playerTurn].chooseAction(hero: hero)
            // Choix de la cible
            let target = players[playerTurn].chooseTarget(champ: hero, action: actionChoice, ennemy: players[(playerTurn + 1) % 2])
            // Résolution de l'action
            resolveAction(hero: hero, actionChoice: actionChoice, target: target)
            // Vérification de fin de jeu
            players[playerTurn].addTurn()
            endGame = isGameEnd()
            if !endGame {
                // Changement de joueur
                playerTurn = (playerTurn + 1) % 2
                print("\nAu tour du Joueur \(playerTurn + 1)\n")
                Thread.sleep(forTimeInterval: 1)
            }
        }
    }
    
    // Affichage des statistiques de fin de partie
    func endGameStats() {
        print("\n\nFin de la partie")
        Thread.sleep(forTimeInterval: 1)
        print("Le gagnant est le Joueur \(playerTurn + 1) !")
        Thread.sleep(forTimeInterval: 1)
        print("Nombre de tours joués : \(players[playerTurn].totalTurn)\n")
        Thread.sleep(forTimeInterval: 1)
        // Affichage des statistiques des Champions du joueur gagnant
        print("Joueur \(playerTurn + 1)")
        for x in 0...2 {
            players[playerTurn].heroes[x].displayChampionAtEnd()
        }
        Thread.sleep(forTimeInterval: 1)
        // Affichage des statistiques des Champions du joueur perdant
        print("\nJoueur \(((playerTurn + 1) % 2) + 1)")
        for x in 0...2 {
            players[(playerTurn + 1) % 2].heroes[x].displayChampionAtEnd()
        }
        Thread.sleep(forTimeInterval: 1)
        print("\nMerci d'avoir joué !")
        Thread.sleep(forTimeInterval: 1)
    }
    
    // Résolution de l'action choisie
    func resolveAction(hero: Int, actionChoice: Int, target: Int) {
        // Si l'action est attaquer
        if actionChoice == 1 {
            // Définition de l'index ennemi
            let ennemy = (playerTurn + 1) % 2
            print("\n" + players[playerTurn].heroes[hero].weapon!.weaponEmoji + " " + players[playerTurn].heroes[hero].name + " attaque " + players[ennemy].heroes[target].name + " " + players[playerTurn].heroes[hero].weapon!.weaponEmoji)
            Thread.sleep(forTimeInterval: 1)
            // Définition du montant des dégâts
            let damage = players[playerTurn].heroes[hero].weapon!.randomDamage()
            // Ajout des dégâts aux statistiques du Champion attaquant
            players[playerTurn].heroes[hero].addTotalDamage(damage)
            // Champion attaqué prend les dégâts
            players[ennemy].heroes[target].getDamage(damage: damage)
        // Si l'action est soigner
        } else if actionChoice == 2 {
            // Si le Champion s'est ciblé lui même
            if hero == target {
                print("💊 " + players[playerTurn].heroes[hero].name + " se soigne 💊")
            // Sinon s'il a ciblé un allié
            } else {
                print("💊 " + players[playerTurn].heroes[hero].name + " soigne " + players[playerTurn].heroes[target].name + " 💊")
            }
            Thread.sleep(forTimeInterval: 1)
            // Définition du montant des soins
            let heal = players[playerTurn].heroes[hero].weapon!.randomHeal()
            // Ajout des soins aux statistiques du Champion soignant
            players[playerTurn].heroes[hero].addTotalHeal(heal)
            // Champion soigné
            players[playerTurn].heroes[target].getHeal(heal: heal)
        }
    }
    
    // Vérification de fin de tour
    func isGameEnd() -> Bool {
        if players.count == 2 {
            // Vérifie le nombre de Champion en vie
            players[0].checkTeamAlive()
            players[1].checkTeamAlive()
            // Retourne false si les deux joueurs ont encore des Champions en vie
            return !(players[0].alliesAlive > 0 && players[1].alliesAlive > 0)
        }
        return true
    }
}
