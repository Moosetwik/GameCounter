//
//  GameTimer.swift
//  GameCounter
//
//  Created by Nick Jones on 9/4/2022.
//

import Foundation
import SwiftUI
import Combine



class GameTime: ObservableObject {
    
    @Published var gameTimeSeconds = 0
    
    
    
    init(){
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            
            self.gameTimeSeconds += 1
        
        })
  
    }
    
    
    
}

