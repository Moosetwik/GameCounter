//
//  SettingsModel.swift
//  GameCounter
//
//  Created by Nick Jones on 9/5/2022.
//

import Foundation

class Settings {
    enum GameMode {
        case commander
        case standard

    }

    
    func getGameMode(gameMode: GameMode) -> Int? {
        switch gameMode {
        case .commander:
            return 40
        case .standard:
            return 20
        }
    }
    
    
}
