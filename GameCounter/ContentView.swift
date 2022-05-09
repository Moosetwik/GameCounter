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
    
    var body: some View {

        VStack(spacing: 0) {
            
            //Upper Counter
            
            PlayerRectView(lifeLog: $lifeLog.lifeLogP2, damageTaken: $lifeLog.damageTakenP2, rectColor: .purple)
                .rotationEffect(.degrees(180))
            CentreView(lifeLog: $lifeLog)
                .frame(height: 75)
            PlayerRectView(lifeLog: $lifeLog.lifeLogP1, damageTaken: $lifeLog.damageTakenP1, rectColor: .blue)
                

        }
        .ignoresSafeArea()
        
    }
}

struct PlayerRectView: View {
    
    @State var lifeTotal = 20
    @Binding var lifeLog: [Int]
    @Binding var damageTaken: [Int]
    @State var rectColor: Color
    
    var body: some View {
        
        ZStack{
            Rectangle()
                .foregroundColor(rectColor)
            
            HStack{
                LifeChangeButtonView(lifeTotal: $lifeTotal, damage: 0, damageTaken: $damageTaken, lifeLog: $lifeLog)
                
            }
            
            Text("\(lifeTotal)")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .font(.system(size: 220))
                .minimumScaleFactor(0.1)
                .lineLimit(1)
                .foregroundColor(.black)
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






