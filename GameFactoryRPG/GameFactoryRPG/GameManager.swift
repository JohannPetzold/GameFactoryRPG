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
    
    /* Vérifie les constantes avant de lancer la partie pour éviter les erreurs */
    func verifyConstants() -> Bool {
        var launchGame = true
        if RATE_CHEST < 2 {
            print("La constate RATE_CHEST doit être supérieure à 1")
            launchGame = false
        }
        if HEROES_NUMBER < 1 {
            print("La constante HEROES_NUMBER doit être supérieure à 0 (valeur recommandée : 3)")
            launchGame = false
        }
        if HP_MAX < 10 || HP_MAX % 10 != 0 {
            print("La constante HP_MAX doit être à 10 minimum et doit être un multiple de 10 (valeur recommandée : 100)")
            launchGame = false
        }
        if !verifyDice(min: MIN_DICE_DAMAGE, max: MAX_DICE_DAMAGE, minStr: "MIN_DICE_DAMAGE", maxStr: "MAX_DICE_DAMAGE") {
            launchGame = false
        }
        if !verifyDice(min: MIN_DAMAGE, max: MAX_DAMAGE, minStr: "MIN_DAMAGE", maxStr: "MAX_DAMAGE") {
            launchGame = false
        }
        if !verifyDice(min: MIN_DICE_HEAL, max: MAX_DICE_HEAL, minStr: "MIN_DICE_HEAL", maxStr: "MAX_DICE_HEAL") {
            launchGame = false
        }
        if !verifyDice(min: MIN_HEAL, max: MAX_HEAL, minStr: "MIN_HEAL", maxStr: "MAX_HEAL") {
            launchGame = false
        }
        return launchGame
    }
    
    private func verifyDice(min: Int, max: Int, minStr: String, maxStr: String) -> Bool {
        if min >= max || min < 1 || max < 2 {
            print(minStr + " doit être supérieure à 0, " + maxStr + " doit être supérieure à 1 et " + minStr + " est forcément inférieure à " + maxStr)
            return false
        }
        return true
    }
}
