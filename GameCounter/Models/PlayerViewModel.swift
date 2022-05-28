//
//  PlayerViewModel.swift
//  GameCounter
//
//  Created by Nick Jones on 26/5/2022.
//

import Foundation
import SwiftUI

class Player {
   
    
    var lifeTotal: Int
    var lifeHistory: [Int]
    var bgColor: Color
    
    
    init(lifeTotal: Int, lifeHistory: [Int], bgColor: Color) {
        self.lifeTotal = lifeTotal
        self.lifeHistory = lifeHistory
        self.bgColor = bgColor
        
    }
}
