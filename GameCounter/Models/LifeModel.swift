//
//  LifeModel.swift
//  GameCounter
//
//  Created by Nick Jones on 7/5/2022.
//

import Foundation

struct LifeHistory {
    var id = UUID()
    var lifeLogP1: [Int]
    var damageTakenP1: [Int]
    
    var lifeLogP2: [Int]
    var damageTakenP2: [Int]
    
}
