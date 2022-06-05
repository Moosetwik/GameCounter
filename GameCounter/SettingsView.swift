//
//  SettingsView.swift
//  GameCounter
//
//  Created by Nick Jones on 1/6/2022.
//

import SwiftUI

enum Game: String, Equatable, CaseIterable {
    case mtg = "Magic: The Gathering",
         fab = "Flesh and Blood",
         ygo = "Yu-Gi-Oh!",
         pkm = "Pokémon",
         cst = "Custom Settings"
}
       
struct GamePresets {
  
    var modeList = ["Standard", "Commander"]
    
    mutating func chooseMode(mode: Game) {
        switch mode {
        case .mtg:
            modeList = ["Standard", "Commander"]
        case .ygo:
            modeList = ["Y1", "Y2"]
        case .pkm:
            modeList = ["P1", "P2"]
        case .fab:
            modeList = ["Blitz", "Classic Constructed"]
        case .cst:
            modeList = [""]
        }
    }
    var selectedGame = Game.mtg
    var selectedMode = "Standard"
}

struct SettingsView: View {
    @ObservedObject var settings: Settings
    @Binding var settingsPresented: Bool
    @State var gamePresets = GamePresets()

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
                        Text("\(settings.playerCount)")
                        Stepper("", value: $settings.playerCount, in: 2...4, step: 1)
                            .labelsHidden()
                    }
                    
                    HStack{
                        Text("Player banners")
                        Spacer()
                        Toggle("", isOn: $settings.bannerVisible)
                    }
                    
                }
                
                //Game mode section
                Section("Game Selection") {

                    PickerView(selection: $gamePresets.selectedGame, title: "Game")
                        .onChange(of: gamePresets.selectedGame) { _ in
                            gamePresets.chooseMode(mode: gamePresets.selectedGame)
                            print(gamePresets.modeList)
                            gamePresets.selectedMode = gamePresets.modeList[0]
                        }
                    
                    ModePickerView(pickerItems: $gamePresets.modeList, selection: $gamePresets.selectedMode, title: "Game Type")
                   
                }
                
                //Game specific settings
                Section("Game Settings") {
                    HStack{
                        Text("Equal starting life")
                        Spacer()
                        Toggle("", isOn: $equalLife)
                    }
                    
                    if !equalLife {
                        ForEach(0..<settings.playerCount, id: \.self) { player in
                            PlayerLifeSettings(startingLife: $playerLife[player], playerName: "Player \(player + 1)")
                        }
                        
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
            .toolbar {
                Button("Done") {
                    settingsPresented = false
                }
            }
        }
    }
}
struct PlaceHolder_View: View {
    @ObservedObject var settings = Settings()

    var body: some View {
        SettingsView(settings: settings, settingsPresented: .constant(true))
    }
}
struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        PlaceHolder_View().previewDevice("iPhone 12 Pro")
        
    }
}

struct PickerView: View {
    var pickerItems = Game.allCases
    @Binding var selection: Game
   
    var title: String

    var body: some View {
        VStack {
            Picker(title, selection: $selection) {
                ForEach(Game.allCases, id: \.self) { game in
                    Text(game.rawValue)
                }
            }
        }

    }
}

struct ModePickerView: View {
    @Binding var pickerItems: [String]
    @Binding var selection: String
   
    var title: String

    var body: some View {
        VStack {
            Picker(title, selection: $selection) {
                ForEach(pickerItems, id: \.self) { game in
                    Text(game)
                }
            }
        }

    }
}

struct PlayerLifeSettings: View {
    @Binding var startingLife: Int
    var playerName: String
    var body: some View {
        HStack{
        Text(playerName)
        Spacer()
        Text("\(startingLife)")
        Stepper("", value: $startingLife, in: 5...100, step: 5)
            .labelsHidden()
        }
    }
}
