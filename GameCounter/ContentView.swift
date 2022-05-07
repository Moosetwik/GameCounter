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
    @State var lifeLogP1: LifeHistory
    @State var lifeLogP2: [Int]
    var body: some View {

        VStack(spacing: 0) {
            
            //Upper Counter
            
            PlayerRectView(lifeLog: $lifeLogP2, damageTaken: $lifeLogP1.damageTakenP2, rectColor: .purple)
                .rotationEffect(.degrees(180))
            CentreView(lifeLogP1: $lifeLogP1)
                .frame(height: 75)
            PlayerRectView(lifeLog: $lifeLogP1.lifeLogP1, damageTaken: $lifeLogP1.damageTakenP1, rectColor: .blue)

        }
        .ignoresSafeArea()
        
    }
}

struct PlayerRectView: View {
    
    @State var lifeTotal = 20
    @Binding var lifeLog: [Int]
    @Binding var damageTaken: [Int]
    var rectColor: Color
    
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






