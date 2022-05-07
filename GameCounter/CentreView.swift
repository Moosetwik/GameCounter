//
//  CentreView.swift
//  GameCounter
//
//  Created by Nick Jones on 11/4/2022.
//

import SwiftUI

struct CentreView: View {
    @ObservedObject var gameTimeSeconds = GameTime()
    
    
    @State private var historyPresented = false
    @State private var settingsPresented = false
    @Binding var lifeLog: LifeHistory
    
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.black)
            
            
            Text(gameTimeSeconds.gameTimeSeconds.convertedTime)
                .foregroundColor(.white)
            HStack {
                
                
                
                Button {
                    self.historyPresented = true
                    
                    
                } label: {
                    Image(systemName: "scroll")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .padding(.all, 25.0)
                        .sheet(isPresented: $historyPresented) {
                            
                            HistoryView(historyPresented: $historyPresented, lifeLog: $lifeLog)
                                .padding()
                        }
                    
                    
                    
                }
                
                Spacer()
                
                Button {
                    self.settingsPresented = true
                    
                } label: {
                    Image(systemName: "gear")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .padding(.all, 25.0)
                        .sheet(isPresented: $settingsPresented) {
                            
                            SettingsView(settingsPresented: $settingsPresented)
                                .padding()
                        }
                }
                
            }
        }
        
        
    }
}

struct SettingsView: View {
    @Binding var settingsPresented: Bool
    
    var body: some View {
        NavigationView {
            Rectangle()
                .foregroundColor(.blue)
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                        settingsPresented = false
                    } label: {
                        Text("Done")
                    }
                    
                }
            
        }
        
    }
}





