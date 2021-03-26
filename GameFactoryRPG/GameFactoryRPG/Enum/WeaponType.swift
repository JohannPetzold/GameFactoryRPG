//
//  WeaponType.swift
//  GameFactoryRPG
//
//  Created by Johann Petzold on 24/03/2021.
//

import Foundation

enum WeaponType: String, CaseIterable {
    case bow = "Arc"
    case sword = "Épée"
    case wand = "Bâton"
    
    func getWeaponEmoji() -> String {
        switch self {
        case .bow: return "🏹"
        case .sword: return "⚔️"
        case .wand: return "⚡️"
        }
    }
    
    func displayTypeForChest() -> String {
        switch self {
        case .bow: return "un " + self.rawValue
        case .sword: return "une " + self.rawValue
        case .wand: return "un " + self.rawValue
        }
    }
}
