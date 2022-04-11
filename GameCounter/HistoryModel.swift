//
//  HistoryModel.swift
//  GameCounter
//
//  Created by Nick Jones on 11/4/2022.
//

import Foundation


struct PlayerHistory {
    
    var lifeLost: Int
    
}

func all() -> [PlayerHistory] {
    return [PlayerHistory(lifeLost: 0)
    ]
}

func captureLifeLost() {
    
}
