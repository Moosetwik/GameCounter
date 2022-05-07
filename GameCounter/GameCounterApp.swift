//
//  GameCounterApp.swift
//  GameCounter
//
//  Created by Nick Jones on 9/4/2022.
//

import SwiftUI

@main
struct GameCounterApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView(lifeLogP1: LifeHistory(id: UUID.init(), lifeLogP1: [20], damageTakenP1: [0], lifeLogP2: [20], damageTakenP2: [4]), lifeLogP2: [20])
        }
    }
}
