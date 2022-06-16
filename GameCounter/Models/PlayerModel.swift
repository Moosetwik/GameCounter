//
//  PlayerViewModel.swift
//  GameCounter
//
//  Created by Nick Jones on 26/5/2022.
//

import Foundation
import SwiftUI
import Combine

class Player: ObservableObject {
    @Published var startLife: Int
    @Published var currentLife: Int
    @Published var lifeHistory: [Int]
    @Published var name: String
    @Published var bgColor: Color
 
    init(startLife: Int, currentLife: Int, lifeHistory: [Int], name: String, bgColor: Color) {
        self.startLife = startLife
        self.currentLife = currentLife
        self.lifeHistory = lifeHistory
        self.name = name
        self.bgColor = bgColor
    }

}
