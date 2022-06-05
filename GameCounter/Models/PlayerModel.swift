//
//  PlayerViewModel.swift
//  GameCounter
//
//  Created by Nick Jones on 26/5/2022.
//

import Foundation
import SwiftUI

class Player: ObservableObject {
    @Published var startLife: Int
    @Published var currentLife: Int
    @Published var lifeHistory: [Int]
    @Published var bgColor: Color
    
    

    init(startLife: Int, currentLife: Int, lifeHistory: [Int], bgColor: Color) {
        self.startLife = startLife
        self.currentLife = currentLife
        self.lifeHistory = lifeHistory
        self.bgColor = bgColor
    }
    
    func returnPlayers() -> [Player] {
        return [Player1(startLife: 20, currentLife: 20, lifeHistory: [20], bgColor: .player1Color),
                Player2(startLife: 20, currentLife: 20, lifeHistory: [20], bgColor: .player2Color),
                Player3(startLife: 20, currentLife: 20, lifeHistory: [20], bgColor: .player3Color),
                Player4(startLife: 20, currentLife: 20, lifeHistory: [20], bgColor: .player4Color)]
    }
    
}

class Player1: Player {
}

class Player2: Player {
}

class Player3: Player {
}

class Player4: Player {
}
