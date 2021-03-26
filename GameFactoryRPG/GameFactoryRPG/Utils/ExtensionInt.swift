//
//  ExtensionInt.swift
//  GameFactoryRPG
//
//  Created by Johann Petzold on 25/03/2021.
//

import Foundation

extension Int {
    func getPercentage(_ percentage: Int) -> Int {
        var result: Double = 0
        result = (Double(self) * Double(percentage)) / Double(100)
        return Int(result)
    }
}
