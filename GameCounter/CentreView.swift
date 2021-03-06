//
//  CentreView.swift
//  GameCounter
//
//  Created by Nick Jones on 11/4/2022.
//

import SwiftUI
import Combine


struct CentreView: View {
    
    @State var rectHeight = 50.0
    
    @State private var historyPresented = false
    @State private var settingsPresented = false
    @Binding var lifeLog: LifeHistory
    @Binding var playerCount: Int
    @State var commanderName = "Commander Name"
    var body: some View {
        
        
            HStack(spacing: 0) {
                
                ZStack(alignment: .center) {
                    Rectangle()
                        .foregroundColor(.black)
                        .frame(height: rectHeight)
                    
                    
                    HStack {
                        Button {
                            self.historyPresented = true
                            
                        } label: {
                            Image(systemName: "list.bullet.circle")
                                .resizable()
                                .frame(width: rectHeight / 2, height: rectHeight / 2, alignment: .center)
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(.white)
                                
                                
                                .sheet(isPresented: $historyPresented) {
                                    
                                    Test_View(historyPresented: $historyPresented, commanderName: $commanderName)

                                }
                            
                    }
                        Text(commanderName)
                    }
                    
                  
                    
                    
                }
                
                Rectangle()
                    .foregroundColor(.black)
                    .frame(width: 100, height: rectHeight)
                    .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 0)
                
                ZStack {
                    
                    Rectangle()
                        .foregroundColor(.black)
                        .frame(height: rectHeight)
                        .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 0)
                    
                    Menu {
                        Button {
                            playerCount -= 1
                            
                        } label: {
                            Text("Player count")
                            Image(systemName: "person.2.circle")
                        }
                        
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .resizable()
                            .frame(width: rectHeight / 2, height: rectHeight / 2, alignment: .center)
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(.white)

                    } primaryAction: {
                        playerCount += 1
                    }
                    
                    
                }
                
            }
 
    }
}





