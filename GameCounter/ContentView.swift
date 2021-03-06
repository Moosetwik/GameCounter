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


    @State var playerCount = 2
    
    
   
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.black)
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                
                if playerCount == 2 {
                    
                    PlayerRectView(lifeLog: $lifeLog.lifeLogP2, damageTaken: $lifeLog.damageTakenP2, rectColor: .player2Color, rotation: 180, rotated: 2, isEven: true, player: 2)

                    PlayerRectView(lifeLog: $lifeLog.lifeLogP1, damageTaken: $lifeLog.damageTakenP1, rectColor: .player1Color, rotation: 0, rotated: 0, isEven: false, player: 1)

                } else if playerCount == 3 {
                    
                    HStack(spacing: 0) {
                        PlayerRectView(lifeLog: $lifeLog.lifeLogP2, damageTaken: $lifeLog.damageTakenP2, rectColor: .player2Color, rotation: 180, rotated: 2, isEven: true, player: 2)
                            .ignoresSafeArea()
                        PlayerRectView(lifeLog: $lifeLog.lifeLogP2, damageTaken: $lifeLog.damageTakenP2, rectColor: .player3Color, rotation: 180, rotated: 2, isEven: false, player: 3)
                    }

                    PlayerRectView(lifeLog: $lifeLog.lifeLogP1, damageTaken: $lifeLog.damageTakenP1, rectColor: .player1Color, rotation: 0, rotated: 0, isEven: false, player: 1)
                    
                } else if playerCount == 4 {
                    HStack(spacing: 0) {
                        PlayerRectView(lifeLog: $lifeLog.lifeLogP2, damageTaken: $lifeLog.damageTakenP2, rectColor: .player2Color, rotation: 180, rotated: 2, isEven: true, player: 2)
                            .ignoresSafeArea()
                        
                        PlayerRectView(lifeLog: $lifeLog.lifeLogP2, damageTaken: $lifeLog.damageTakenP2, rectColor: .player3Color, rotation: 180, rotated: 2, isEven: false, player: 3)
                            
                    }
                    
                    
                    HStack(spacing: 0) {
                        PlayerRectView(lifeLog: $lifeLog.lifeLogP1, damageTaken: $lifeLog.damageTakenP1, rectColor: .player4Color, rotation: 0, rotated: 0, isEven: true, player: 4)
                        PlayerRectView(lifeLog: $lifeLog.lifeLogP1, damageTaken: $lifeLog.damageTakenP1, rectColor: .player1Color, rotation: 0, rotated: 0, isEven: false, player: 1)
                    }
                    
                }
                
            }
            .ignoresSafeArea()
            CentreView(lifeLog: $lifeLog, playerCount: $playerCount)
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

struct PlayerRectView: View {
   
    @State var lifeTotal = 20
    @Binding var lifeLog: [Int]
    @Binding var damageTaken: [Int]
    @State var rectColor: Color
    @State var rotation: Double
    @State var rotated: Int
    @State var scaleValue = 1.0
    
    var isEven: Bool
    var player: Int
    
    var animation: Animation {
        Animation.easeOut
    }
    
   
    
    func rotate() {
            rotation += 90
        
        rotated += 1
        if scaleValue == 1.0 {
            scaleValue = 0.75
        } else {
            scaleValue = 1.0
        }
        
        if rotated == 4 {
            rotated = 0
        }
        print(rotation)
        print(rotated)
    }
    
    var body: some View {
        
        ZStack{
            Rectangle()
                .foregroundColor(rectColor)
                
            
           
            HStack{
                
                LifeChangeButtonView(lifeTotal: $lifeTotal, damage: 0, rectColor: $rectColor, damageTaken: $damageTaken, lifeLog: $lifeLog, rotation: $rotation, rotated: $rotated)

            }
            
    
            if player == 1 {
                VStack {
                    HStack {
                        
                        Button {
                            rotate()
                            print("rotate")
                        } label: {
                            Image(systemName: "rotate.right.fill")
                                .frame(minWidth: 80, minHeight: 80)
                                .contentShape(Rectangle())
                                .foregroundColor(.black)
                                
                            
                        }
                        .padding(30)
                        .offset(x: 0, y: 0)
                        
                        Spacer()
                    }
                    Spacer()
                }

            } else if player == 2 {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            rotate()
                            print("rotate")
                        } label: {
                            Image(systemName: "rotate.right.fill")
                                .frame(minWidth: 80, minHeight: 80)
                                .contentShape(Rectangle())
                                .foregroundColor(.black)
                                .rotationEffect(.degrees(180))
                                
                            
                        }
                        .padding(30)
                        .offset(x: 0, y: 0)
                        
                        
                    }
                    
                }
                
            } else if player == 3 {
                VStack {
                    Spacer()
                    HStack {
                        
                        Button {
                            rotate()
                            print("rotate")
                        } label: {
                            Image(systemName: "rotate.right.fill")
                                .frame(minWidth: 80, minHeight: 80)
                                .contentShape(Rectangle())
                                .foregroundColor(.black)
                                .rotationEffect(.degrees(180))
                                
                            
                        }
                        
                        .padding(30)
                        .offset(x: 0, y: 0)
                        
                        Spacer()
                    }
                   
                }
             
            } else if player == 4 {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            rotate()
                            print("rotate")
                        } label: {
                            Image(systemName: "rotate.right.fill")
                                .frame(minWidth: 80, minHeight: 80)
                                .contentShape(Rectangle())
                                .foregroundColor(.black)
                            
                                
                            
                        }
                        .padding(30)
                        .offset(x: 0, y: 0)
                        
                        
                    }
                    Spacer()
                }
             
            }

            
            HStack{
                Spacer()
                Image(systemName: "minus")
                    .font(Font.system(size: 20, weight: .bold))
                    .foregroundColor(.black.opacity(0.50))
                
                Text("\(lifeTotal)")
                    .fontWeight(.medium)
                    .font(.system(size: 220))
                    .padding([.leading, .trailing], 10)
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                    .foregroundColor(.black)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                    .allowsHitTesting(false)
                    .monospacedDigit()
                    .ignoresSafeArea()
                    
                    
                Image(systemName: "plus")
                    .font(Font.system(size: 20, weight: .bold))
                    .minimumScaleFactor(0.1)
                    .foregroundColor(.black.opacity(0.50))
                
                Spacer()
                
            }
            .padding()
            
            .rotationEffect(.degrees(rotation))
            .scaleEffect(scaleValue)
            .animation(.spring(), value: rotation)
            

        }
        
    }
        
}
