//
//  ButtonView.swift
//  GameCounter
//
//  Created by Nick Jones on 11/4/2022.
//

import SwiftUI

struct LifeChangeButtonView: View {
    
    @Binding var lifeTotal: Int
    @State private var isTapped = false
    let isPositive: Bool
    
    var body: some View {
        Button {
            
            isTapped = true
            
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { _ in
                
                isTapped = false
            
            })
            
            if isPositive {
                lifeTotal += 1
            
            } else {
                lifeTotal -= 1
            }
            
            
        } label: {
            Text("")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    
                    Color(isTapped ? .white : .clear)
                        .animation(.easeInOut(duration: 0.1))
                    
                    .opacity(0.15))
        }
        
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
