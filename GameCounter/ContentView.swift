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

struct ContentView: View {
    @State var lifeLog: LifeHistory
    @State var timerSize: CGFloat = 100.0
    @State var strokeSize: CGFloat = 10.0
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.white)
                .ignoresSafeArea()
                
        VStack(spacing: 0) {
            
            //Upper Counter
            
            HStack {
                PlayerRectView(lifeLog: $lifeLog.lifeLogP2, damageTaken: $lifeLog.damageTakenP2, rectColor: .purple)
                    .rotationEffect(.degrees(180))
            }
            CentreView()
            HStack {
                PlayerRectView(lifeLog: $lifeLog.lifeLogP1, damageTaken: $lifeLog.damageTakenP1, rectColor: .blue)
            }
                

        }
        .ignoresSafeArea()

            Circle()
                 .foregroundColor(.black)
                 .frame(width: timerSize + strokeSize, height: timerSize + strokeSize)
                 .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 0)
            TimerView(timerSize: $timerSize, strokeSize: $strokeSize)
            
        }
        
    }
}

struct PlayerRectView: View {
    
    @State var lifeTotal = 20
    @Binding var lifeLog: [Int]
    @Binding var damageTaken: [Int]
    @State var rectColor: Color

    var body: some View {
        
        ZStack{

          HStack{
              LifeChangeButtonView(lifeTotal: $lifeTotal, damage: 0, rectColor: $rectColor, damageTaken: $damageTaken, lifeLog: $lifeLog)
                
            }
            
            Text("\(lifeTotal)")
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .font(.system(size: 220))
                .minimumScaleFactor(0.7)
                .lineLimit(1)
                .foregroundColor(.black)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                .allowsHitTesting(false)
                .monospacedDigit()
                

            HStack{
                Image(systemName: "minus")
                    .font(Font.system(size: 20, weight: .bold))
                    
                Spacer()
                Image(systemName: "plus")
                    .font(Font.system(size: 20, weight: .bold))
            }
            .padding(30)
            .opacity(0.2)
            
            
 
        } 
    }
}






