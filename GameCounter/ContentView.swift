//
//  ContentView.swift
//  GameCounter
//
//  Created by Nick Jones on 9/4/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        
        
        VStack(spacing: 0) {
            
            //Upper Counter
            
            PlayerRectView(rectColor: .purple)
                .rotationEffect(.degrees(180))
            
            
            Rectangle()
                .foregroundColor(.black)
                .frame(height: 50)
                
                
            PlayerRectView(rectColor: .blue)
            
            
        }
        .ignoresSafeArea()
        
    }
}

struct PlayerRectView: View {
    
    @State private var lifeTotal = 20
    
    var rectColor: Color
    
    var body: some View {
        
        ZStack{
            Rectangle()
                .foregroundColor(rectColor)
            Text("\(lifeTotal)")
               
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .font(.system(size: 220))
                .minimumScaleFactor(0.1)
                .lineLimit(1)
            
            HStack{
               
                LifeChangeButton(lifeTotal: $lifeTotal, isPositive: false)
              LifeChangeButton(lifeTotal: $lifeTotal, isPositive: true)
                
            }
               
                
            
        }
        
    }
}

struct LifeChangeButton: View {
    
    @Binding var lifeTotal: Int
    let isPositive: Bool
    
    var body: some View {
        Button {
            
            if isPositive {
                lifeTotal += 1
                print(isPositive)
            } else {
                lifeTotal -= 1
            }
            
            
        } label: {
            Text("")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct CentreView: View {
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
