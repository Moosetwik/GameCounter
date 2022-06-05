//
//  SettingsModel.swift
//  GameCounter
//
//  Created by Nick Jones on 9/5/2022.
//

import Foundation

class Settings: ObservableObject {
    @Published var playerCount = 2
    @Published var bannerVisible = true
    
}
