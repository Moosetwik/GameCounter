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
    var body: some View {
        
        
            HStack(spacing: 0) {
                
                ZStack(alignment: .center) {
                    Rectangle()
                        .foregroundColor(.black)
                        .frame(height: rectHeight)
                    
                    
                    Button {
                        self.historyPresented = true
                        
                    } label: {
                        Image(systemName: "list.bullet.circle")
                            .resizable()
                            .frame(width: rectHeight / 2, height: rectHeight / 2, alignment: .center)
                            
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(.white)
                            
                            
                            .sheet(isPresented: $historyPresented) {
                                
                                HistoryView(historyPresented: $historyPresented, lifeLog: $lifeLog)
                                    .padding()
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
                    
                    Menu {
                        Button {
                            print("button")
                        } label: {
                            Text("Player count")
                            Image(systemName: "person.2.circle")
                        }
                        
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .resizable()
                            .frame(width: rectHeight / 2, height: rectHeight / 2, alignment: .center)
                            .padding()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                        
                            .sheet(isPresented: $settingsPresented) {
                                
                                SettingsView(settingsPresented: $settingsPresented)
                                    .padding()
                            }
                    }
                    
                }
                
            }
 
    }
}

struct OldCentreView: View {
    

    
    
    @State private var historyPresented = false
    @State private var settingsPresented = false
    @Binding var lifeLog: LifeHistory
    
    
    
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.black)
            
            
            HStack {
                
                Button {
                    self.historyPresented = true
                    
                } label: {
                    Image(systemName: "list.dash")
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
                
                Spacer()
                
                Button {
                    self.settingsPresented = true
                    
                } label: {
                    Image(systemName: "gearshape")
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







