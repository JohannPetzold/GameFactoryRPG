//
//  main.swift
//  GameFactoryRPG
//
//  Created by Johann Petzold on 23/03/2021.
//

import Foundation

var gameManager = GameManager()

gameManager.startGame()
gameManager.chooseCharacters()
gameManager.getPlayerTurn()
gameManager.gameLoop()
gameManager.endGameStats()
