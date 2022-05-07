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
    @Binding var lifeLogP1: LifeHistory
    
    
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
                            
                            HistoryView(historyPresented: $historyPresented, lifeLogP1: $lifeLogP1)
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





struct HistoryView: View {
    
    
    @Binding var historyPresented: Bool
    @Binding var lifeLogP1: LifeHistory
    
    
    var body: some View {
        NavigationView {
            
            List() {
                
                ForEach(Array(zip(lifeLogP1.lifeLogP1.indices, lifeLogP1.lifeLogP1)), id: \.0) { index, item in
                    HistoryCell(lifeLogP1: item, damageTaken: lifeLogP1.damageTakenP1[index])
                }
                
            
            }
            
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    historyPresented = false
                } label: {
                    Text("Done")
                }
                
            }
            
        }
        
    }
}

struct HistoryCell: View {
    var lifeLogP1: Int
    var damageTaken: Int
    
    var body: some View {
        
        HStack{
            Text("\(lifeLogP1)")
                .font(.largeTitle)
                .padding()
            Spacer()
            Text("\(damageTaken)")
                .font(.largeTitle)
                .padding()
        }
    }
}

struct HistoryCell_Preview: PreviewProvider {
    static var previews: some View {
        HistoryCell(lifeLogP1: 25, damageTaken: 5).previewLayout(.sizeThatFits)
    }
}

