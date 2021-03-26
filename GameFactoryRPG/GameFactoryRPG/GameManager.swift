import Foundation

// La classe GameManager permet de gérer les différentes phases du jeu
class GameManager {
    //MARK: Propriétés
    private var players: [Player]
    private var allNames: [String]
    private var playerTurn: Int
    private var ennemy: Int
    private var endGame: Bool
    
    //MARK: Init
    init() {
        players = []
        allNames = []
        playerTurn = 0
        ennemy = 0
        endGame = false
    }
    
    //MARK: Méthodes
    func startGame() {
        print("⚔️ ⚔️ ⚔️ Bienvenue dans GameFactoryRPG ⚔️ ⚔️ ⚔️\n")
        Thread.sleep(forTimeInterval: 1)
    }
    
    /* Création des personnages de chaque joueur */
    func chooseCharacters() {
        print("Entrer les informations du Joueur 1")
        
        players.append(Player(allNames: allNames))
        getTeamNames(players[0])
        
        print("\nEntrer les informations du Joueur 2")
        
        players.append(Player(allNames: allNames))
        
        print("\nLa partie peut commencer !")
        Thread.sleep(forTimeInterval: 1)
    }
    
    /* Choix aléatoire du joueur qui commence */
    func getPlayerTurn() {
        print("Choix du joueur qui va commencer...")
        
        playerTurn = Int.random(in: 0...players.count - 1)
        ennemy = (playerTurn + 1) % 2
        
        Thread.sleep(forTimeInterval: 1)
        print("C'est le Joueur \(playerTurn + 1) qui commence\n")
        Thread.sleep(forTimeInterval: 1)
    }
    
    /* La boucle principale du jeu, s'enchaine comme suit :
     choix du héros qui attaque, apparition du coffre, choix de l'action,
     choix de la cible, résolution de l'action, fin du tour */
    func gameLoop() {
        while !endGame {
            print("---------- Joueur \(playerTurn + 1) ----------")
            
            let hero = players[playerTurn].chooseHeroForAction()
            
            let spawnChest = Int.random(in: 1...RATE_CHEST)
            if spawnChest == 1 {
                let chest = Chest(weaponType: players[playerTurn].heroes[hero].weapon.weaponType)
                if chest.chestAppear() {
                    players[playerTurn].heroes[hero].swapWeapon(newWeapon: chest.weapon)
                }
            }
            
            let actionChoice = players[playerTurn].chooseAction(hero: hero)
            
            let target = players[playerTurn].chooseTarget(champ: hero, action: actionChoice, ennemy: players[ennemy])
            
            resolveAction(hero: hero, actionChoice: actionChoice, target: target)
            
            players[playerTurn].addTurn()
            endGame = isGameEnd()
            
            if !endGame {
                playerTurn = (playerTurn + 1) % 2
                ennemy = (playerTurn + 1) % 2
                
                print("\nAu tour du Joueur \(playerTurn + 1)\n")
                Thread.sleep(forTimeInterval: 1)
            }
        }
    }
    
    /* Fin de partie, affichage des statistiques */
    func endGameStats() {
        print("\n\nFin de la partie")
        Thread.sleep(forTimeInterval: 1)
        print("Le gagnant est le Joueur \(playerTurn + 1) !")
        Thread.sleep(forTimeInterval: 1)
        print("Nombre de tours Joueur \(playerTurn + 1) : \(players[playerTurn].totalTurn)")
        Thread.sleep(forTimeInterval: 1)
        print("Nombre de tours Joueur \(ennemy + 1) : \(players[ennemy].totalTurn)\n")
        Thread.sleep(forTimeInterval: 1)

        print("Joueur \(playerTurn + 1)")
        players[playerTurn].displayHeroesAtEnd()
        
        Thread.sleep(forTimeInterval: 1)

        print("\nJoueur \(ennemy + 1)")
        players[ennemy].displayHeroesAtEnd()
        
        Thread.sleep(forTimeInterval: 1)
        print("\nMerci d'avoir joué !")
        Thread.sleep(forTimeInterval: 1)
    }
    
    /* Enregistre les noms des héros du joueur */
    private func getTeamNames(_ player: Player) {
        if player.heroes.count == HEROES_NUMBER {
            for x in 0...2 {
                allNames.append(player.heroes[x].name)
            }
        }
    }
    
    /* Résolution de l'action choisie */
    private func resolveAction(hero: Int, actionChoice: Int, target: Int) {
        // Attaque
        if actionChoice == 1 {
            let emoji = players[playerTurn].heroes[hero].weapon.weaponType.getWeaponEmoji()
            print("\n" + emoji + " " + players[playerTurn].heroes[hero].name + " attaque " + players[ennemy].heroes[target].name + " " + emoji)
            Thread.sleep(forTimeInterval: 1)
            
            let damage = players[playerTurn].heroes[hero].weapon.randomDamage()
            
            players[playerTurn].heroes[hero].addTotalDamage(damage)
            
            players[ennemy].heroes[target].getDamage(damage: damage)
        // Soin
        } else if actionChoice == 2 {
            if hero == target {
                print("💊 " + players[playerTurn].heroes[hero].name + " se soigne 💊")
            } else {
                print("💊 " + players[playerTurn].heroes[hero].name + " soigne " + players[playerTurn].heroes[target].name + " 💊")
            }
            Thread.sleep(forTimeInterval: 1)
            
            let heal = players[playerTurn].heroes[hero].weapon.randomHeal()

            players[playerTurn].heroes[hero].addTotalHeal(heal)

            players[playerTurn].heroes[target].getHeal(heal: heal)
        }
    }
    
    /* Vérifie si l'un des joueurs n'a plus de héros en vie */
    private func isGameEnd() -> Bool {
        if players.count == 2 {
            players[0].checkTeamAlive()
            players[1].checkTeamAlive()
            return !(players[0].alliesAlive > 0 && players[1].alliesAlive > 0)
        }
        return true
    }
}
