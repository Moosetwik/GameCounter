//
//  SettingsView.swift
//  GameCounter
//
//  Created by Nick Jones on 1/6/2022.
//

import SwiftUI

struct GamePresets {
    var gameList = [
        "Magic: The Gathering",
        "Flesh and Blood",
        "Yu-Gi-Oh!",
        "Pokémon",
        "Custom Settings"
    ]
    
    var modeList = ["Standard", "Commander"]
    
    mutating func chooseMode(mode: String) {
        switch mode {
        case "Magic: The Gathering":
            modeList = ["Standard", "Commander"]
        case "Yu-Gi-Oh!":
            modeList = ["Y1", "Y2"]
        case "Pokémon":
            modeList = ["P1", "P2"]
        case "Flesh and Blood":
            modeList = ["Blitz", "Classic Constructed"]
        case "Custom Settings":
            modeList = [""]
        default:
            modeList = ["Failure"]
        }

    }
    var selectedGame = "Magic: The Gathering"
    var selectedMode = "Standard"
}

struct PlayerLifeSettings: View {
    @Binding var startingLife: Int
    var playerName: String
    var body: some View {
        HStack{
        Text(playerName)
        Spacer()
        Text("\(startingLife)")
        Stepper("", value: $startingLife, in: 1...100, step: 5)
            .labelsHidden()
        }
    }
}


struct SettingsView: View {
    @Binding var playerCount: Int
    @State var gamePresets = GamePresets()

    @State var selectedGame = "Magic: The Gathering"
    @State var selectedMode = "Standard"
    
    @State var equalLife = true
    @State var startingLife = 20
   
    @State var playerLife = [20, 20, 20, 20]
    

    
    var body: some View {
        NavigationView() {
            List {
                //General settings
                Section("General Settings") {
                    
                    HStack {
                        Text("Number of players")
                        Spacer()
                        Text("\(playerCount)")
                        Stepper("", value: $playerCount, in: 2...4, step: 1)
                            .labelsHidden()
                    }
                    
                }
                
                //Game mode section
                Section("Game Selection") {

                    PickerView(pickerItems: $gamePresets.gameList, selection: $selectedGame, title: "Game")
                        .onChange(of: selectedGame) { _ in
                            gamePresets.chooseMode(mode: selectedGame)
                            selectedMode = gamePresets.modeList[0]
                        }
                    PickerView(pickerItems: $gamePresets.modeList, selection: $selectedMode, title: "Game Type")
                }
                
                //Game specific settings
                Section("Game Settings") {
                    HStack{
                        Text("Equal starting life")
                        Spacer()
                        Toggle("", isOn: $equalLife)
                    }
                    
                    if !equalLife {
                        ForEach(0..<playerCount, id: \.self) { player in
                            PlayerLifeSettings(startingLife: $playerLife[player], playerName: "Player \(player + 1)")
                        }
                        .animation(.spring(), value: playerCount)
                        HStack{
                            Spacer()
                            Button {
                                for (index, _) in playerLife.enumerated() {
                                    playerLife[index] = 20
                                }
                                print(playerLife)
                            } label: {
                                
                                Text("Reset All")
                                    .foregroundColor(.red)
                                    
                            }
                            

                        }
                    } else {
                        PlayerLifeSettings(startingLife: $startingLife, playerName: "Starting Life")
                    }
                        
                    
                }
    
            }
            .navigationTitle(Text("Settings"))
        }
    }
}
struct PlaceHolder_View: View {
    @State var playerCount = 2
    var body: some View {
        SettingsView(playerCount: $playerCount)
    }
}
struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        PlaceHolder_View().previewDevice("iPhone 12 Pro")
    }
}

struct PickerView: View {
    @Binding var pickerItems: [String]
    @Binding var selection: String
   
    var title: String

    var body: some View {
        VStack {
            Picker(title, selection: $selection) {
                ForEach(pickerItems, id: \.self) {
                    Text($0)
                }
            }
        }

    }
}


