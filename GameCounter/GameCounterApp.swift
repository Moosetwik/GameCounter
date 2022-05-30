//
//  GameCounterApp.swift
//  GameCounter
//
//  Created by Nick Jones on 9/4/2022.
//

import SwiftUI

struct PlaceHolders: View {
    @State var bool = true
    @State var string = "Cheese"
    var body: some View {
        Test_View(historyPresented: $bool, commanderName: $string)
    }
}

@main
struct GameCounterApp: App {
    
    var body: some Scene {
        WindowGroup {
            
            
         ContentView(lifeLog: LifeHistory(lifeLogP1: [20], damageTakenP1: [0], lifeLogP2: [20], damageTakenP2: [0]))
          // PlaceHolders()
        }
    }
}
