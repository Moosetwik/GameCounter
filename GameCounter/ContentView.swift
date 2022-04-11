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

// Main content view



struct ContentView: View {
    var body: some View {
        
        
        
        VStack(spacing: 0) {
            
            //Upper Counter
            
            PlayerRectView(rectColor: .purple)
                .rotationEffect(.degrees(180))
            
            
            CentreView()
                .frame(height: 75)
                
                
            PlayerRectView(rectColor: .blue)
            
            
        }
        .ignoresSafeArea()
        
    }
}

// View that generates

struct PlayerRectView: View {
    
    @State private var lifeTotal = 20
    
    
    var rectColor: Color
    
    var body: some View {
        
        ZStack{
            Rectangle()
                .foregroundColor(rectColor)
            
            HStack{
               
                LifeChangeButtonView(lifeTotal: $lifeTotal, isPositive: false)
              LifeChangeButtonView(lifeTotal: $lifeTotal, isPositive: true)
                
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





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
