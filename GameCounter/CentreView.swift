//
//  CentreView.swift
//  GameCounter
//
//  Created by Nick Jones on 11/4/2022.
//

import SwiftUI
import Combine


struct CentreView: View {
    @ObservedObject var settings: Settings
    @State var rectHeight = 50.0
    
    @State private var historyPresented = false
    @State private var settingsPresented = false
    @Binding var lifeLog: LifeHistory

    @State var commanderName = "Commander Name"
    var body: some View {
        
        
            HStack(spacing: 0) {
                
                ZStack(alignment: .center) {
                    Rectangle()
                        .foregroundColor(.black)
                        .frame(height: rectHeight)
                    
                    
                    HStack {

                        Button {
                            //self.historyPresented = true
                            
                        } label: {
                            Image(systemName: "list.bullet.circle")
                                .resizable()
                                .frame(width: rectHeight / 2, height: rectHeight / 2, alignment: .center)
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(.white)
                                
                                
                                .sheet(isPresented: $historyPresented) {
                                    
                                    HistoryView(historyPresented: $historyPresented, lifeLog: $lifeLog)

                                }
                            
                    }
                        
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

                        Button {
                            settingsPresented = true
                        } label: {
                            Image(systemName: "ellipsis.circle")
                                .resizable()
                                .frame(width: rectHeight / 2, height: rectHeight / 2, alignment: .center)
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(.white)
                        }
                  
                    .sheet(isPresented: $settingsPresented) {
                        
                        SettingsView(settings: settings, settingsPresented: $settingsPresented)

                    }
                    
                    
                }
                
            }
 
    }
}





