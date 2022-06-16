//
//  ContentView.swift
//  GameCounter
//
//  Created by Nick Jones on 9/4/2022.
//

import SwiftUI


extension Int {
    var convertedTime: String {
        
        let minutes = self / 60
        let seconds = self % 60
        return String(format: "%02d", minutes) + ":" + String(format: "%02d", seconds)
    }
    
    var roundUp: Int {
        let rounded = ceil(Double(self) / 2)
        return Int(rounded)
    }
    
    var roundDown: Int {
        let rounded = floor(Double(self) / 2)
        return Int(rounded)
    }
}

extension Color {
    static let player1Color = Color(red: 154 / 255, green: 220 / 255, blue: 255 / 255) // blue rrgb(154, 220, 255)
    static let player2Color = Color(red: 202 / 255, green: 184 / 255, blue: 255 / 255) // purple 177, 156, 217
    static let player3Color = Color(red: 193 / 255, green: 255 / 255, blue: 215 / 255) // green
    static let player4Color = Color(red: 255 / 255, green: 138 / 255, blue: 174 / 255) // pink rgb(255, 138, 174)
    
    func allColours() -> [Color] {
        return [Color.player1Color, Color.player2Color, Color.player3Color, Color.player1Color]
    }
}



struct ContentView: View {
    
    @State var lifeLog: LifeHistory
    @State var timerSize: CGFloat = 100.0
    @State var strokeSize: CGFloat = 10.0
    
    @StateObject var settings = Settings()

    @StateObject var player1 = Player(startLife: 20, currentLife: 20, lifeHistory: [20], name: "Player 1", bgColor: .player1Color)
    @StateObject var player2 = Player(startLife: 20, currentLife: 20, lifeHistory: [20], name: "Player 2", bgColor: .player2Color)
    @StateObject var player3 = Player(startLife: 20, currentLife: 20, lifeHistory: [20], name: "Player 3", bgColor: .player3Color)
    @StateObject var player4 = Player(startLife: 20, currentLife: 20, lifeHistory: [20], name: "Player 4", bgColor: .player4Color)
    var players: [Player] {
        [player1, player2, player3, player4]
    }

    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.white)
                .ignoresSafeArea()
            VStack {
                HStack(spacing: 0) {
                    ForEach(0..<settings.playerCount.roundUp, id: \.self) { p in
                        PlayerView(players: players, player: p + 2, settings: settings, rotation: 180.0, rotationIndex: 2)
                    }
                }
                HStack(spacing: 0) {
                    ForEach(0..<settings.playerCount.roundDown, id: \.self) { p in
                        PlayerView(players: players, player: p, settings: settings)
                    }
                }
            
                }
            .ignoresSafeArea()

            CentreView(settings: settings, lifeLog: $lifeLog)
                .shadow(color: .black.opacity(1.0), radius: 5, x: 0, y: 0)
                .ignoresSafeArea()
            
            Circle()
                .foregroundColor(.black)
                .frame(width: timerSize + strokeSize, height: timerSize + strokeSize)
                .shadow(color: .black.opacity(1.0), radius: 5, x: 0, y: 0)
            TimerView(timerSize: $timerSize, strokeSize: $strokeSize)
            
        }
        
    }
}

struct PlayerView: View {
    var players: [Player]
    var player: Int
    
    @ObservedObject var settings: Settings

    @State var commanderViewPresented = false
    

    var animation: Animation {
        Animation.easeOut
    }
    @State var rotation = 0.0
    @State var isRotated = false
    @State var rotationIndex = 0
    var isFlipped: Bool {
        let num = Int(rotation) / 180
        if (num % 2) == 0 {
            return true
        } else {
            return false
        }
    }
    @State var negTouched = false
    @State var posTouched = false

    var body: some View {
        
        ZStack{
            AdaptiveView(threshold: !isRotated, spacing: 0) {
                ZStack {
                    Rectangle()
                        .foregroundColor(!negTouched ? players[player].bgColor : players[player].bgColor.opacity(0.5))
                        .gesture(DragGesture(minimumDistance: 0)
                            .onChanged({ _ in
                                    negTouched = true
                            })
                                .onEnded({ _ in
                                    negTouched = false
                                    players[player].currentLife -= 1
                                })
                    )
                    
                    Image(systemName: "minus")
                        .font(Font.system(size: 50, weight: .bold))
                        .minimumScaleFactor(0.1)
                        .foregroundColor(players[player].bgColor)
                        .shadow(radius: 10)
                        .rotationEffect(.degrees(rotation))
                    
                }
                ZStack {
                    Rectangle()
                        .foregroundColor(!posTouched ? players[player].bgColor : players[player].bgColor.opacity(0.5))
                        .gesture(DragGesture(minimumDistance: 0)
                            .onChanged({ _ in
                                    posTouched = true
                            })
                                .onEnded({ _ in
                                    posTouched = false
                                    players[player].currentLife += 1
                                })
                    )
                    Image(systemName: "plus")
                        .font(Font.system(size: 50, weight: .bold))
                        .minimumScaleFactor(0.1)
                        .foregroundColor(players[player].bgColor)
                        .shadow(radius: 10)
                    
                }
            }
            .rotationEffect(.degrees(isFlipped ? 0 : 180))

 
            RotateButton(rotation: $rotation, isRotated: $isRotated, player: player, rotationIndex: $rotationIndex)

                Text("\(players[player].currentLife)")
                    .fontWeight(.medium)
                    .font(.system(size: 220))
                    .padding([.leading, .trailing], 10)
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                    .foregroundColor(.black)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                    .allowsHitTesting(false)
                    .monospacedDigit()
                    .rotationEffect(.degrees(rotation))
                    .animation(.spring(), value: rotation)
            
            AdaptiveView(threshold: isRotated, spacing: 0){
                if rotationIndex == 0 || rotationIndex == 3 {
                    Spacer()
                }
                BannerView()
                    .padding()
                    .offset(x: 0, y: -50)
                    .rotationEffect(.degrees(rotation))
                if rotationIndex == 1 || rotationIndex == 2 {
                    Spacer()
                }
            }
            
        }
        
    }
}

struct BannerView: View {
    @State var commanderViewPresented = false
    @State var commanderName = "Adriana, the Giant Flying Scooter"
    @State var commanderColours = ["B", "W", "U", "G", "R"]
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.white.opacity(0.7))
                .shadow(radius: 5.0)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(commanderName)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .foregroundColor(.black)
                        
                    HStack(spacing: 3){
                        ForEach(commanderColours, id: \.self) { colour in
                            Rectangle()
                                .foregroundColor(convertColor(input: colour))
                        }
                    }
                    .frame(height: 3.5)
                }
                .frame(maxHeight: 20)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 5.0)
                .padding(.vertical, 5.0)
                .onTapGesture {
                    commanderViewPresented = true
                }
                Spacer()
        
        }
        .sheet(isPresented: $commanderViewPresented, content: {
            CommanderListView(commanderViewPresented: $commanderViewPresented, commanderName: $commanderName, commanderColours: $commanderColours)
        })
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: 200)
        
    }
}


struct Preview: PreviewProvider {
    static var previews: some View {
   //     ContentView(lifeLog: LifeHistory(lifeLogP1: [20], damageTakenP1: [20], lifeLogP2: [20], damageTakenP2: [20])).previewDevice("iPad Mini (6th Generation)")
        
        ContentView(lifeLog: LifeHistory(lifeLogP1: [20], damageTakenP1: [20], lifeLogP2: [20], damageTakenP2: [20])).previewDevice("iPhone 13 Pro")
       

            
    }
}

struct RotateButton: View {
    @Binding var rotation: Double
    @Binding var isRotated: Bool

    var player: Int
    @Binding var rotationIndex: Int
    
    
    func rotate() {
        rotation += 90
        isRotated.toggle()
        rotationIndex += 1
        if rotationIndex == 4 {
            rotationIndex = 0
        }
        print(player)
    }
    
    var body: some View {
        
        HStack {
            if player == 0 || player == 2 {
                Spacer()
            }
            VStack {
                if 2...3 ~= player {
                    Spacer()
                }
                Button {
                            rotate()
                        } label: {
                            Image(systemName: "rotate.right.fill")
                                .frame(minWidth: 80, minHeight: 80)
                                .contentShape(Rectangle())
                                .foregroundColor(.black)
                        }
                        .padding()
                    
                if 0...1 ~= player {
                    Spacer()
                }
            }
            if player == 1 || player == 3 {
                Spacer()
            }
        }
    }
}
