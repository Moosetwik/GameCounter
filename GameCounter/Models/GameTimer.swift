//
//  GameTimer.swift
//  GameCounter
//
//  Created by Nick Jones on 9/4/2022.
//

import Foundation
import SwiftUI
import Combine



class GameTime {

  
    func cancelTimer(timerType: Cancellable) {
        timerType.cancel()
        print("cancelled")
        return
    }
    
    
    
}

