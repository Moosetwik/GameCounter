//
//  CentreView.swift
//  GameCounter
//
//  Created by Nick Jones on 11/4/2022.
//

import SwiftUI
import Combine


struct CentreView: View {
    
 
    
    @State var player1Name = "Player 1"
    @State var player2Name = "Player 2"
    @State var player1editingText = false
    @State var player2editingText = false
    @State var rectHeight = 50.0
    @FocusState private var isFocused: Bool
     
    
    func editName(player: String) {
        if player == "1" {
            player1editingText = true
        } else if player == "2" {
            player2editingText = true
        }
       isFocused = true
    }
    var body: some View {
        
        ZStack {
            HStack(spacing: 0) {
                ZStack {
                        Rectangle()
                            .foregroundColor(.black)
                            .frame(height: rectHeight)

                    .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 0)
                    if !player1editingText {
                        Text(player1Name)
                            .foregroundColor(.blue)
                            .font(.title)
                            .fontWeight(.semibold)
                            .scaledToFit()
                            .minimumScaleFactor(0.6)
                            .lineLimit(1)
                            .onLongPressGesture {
                                editName(player: "1")
                            }
                    } else {
                        HStack(alignment: .center, spacing: 5) {
                            TextField(player1Name, text: $player1Name)
                                .focused($isFocused)
                                .onSubmit {
                                    player1editingText = false
                                    isFocused = false
                                }
                                .frame(maxHeight: .infinity)
                                .background(Color(.white))
                                
                                .cornerRadius(5)
                                .padding()
                                .foregroundColor(.blue)
                                .font(.title)
                                
                            
                            Button {
                                player1editingText = false
                                isFocused = false
                            } label: {
                                Text("Save")
                                   
                                    .frame(minWidth: 50, maxHeight: .infinity)
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .padding([.top, .bottom, .trailing])
    
                            }
                            
                            
     
                        }
                        .fixedSize(horizontal: false, vertical: true)
                        
    
                    }
                    
                    
                        
                }
                
                Rectangle()
                    .foregroundColor(.black)
                    .frame(width: 145, height: rectHeight)
                    .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 0)
                
                ZStack {
               
                        Rectangle()
                            .foregroundColor(.black)
                        .frame(height: rectHeight)

                    .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 0)
                    
                    if !player2editingText {
                        Text(player2Name)
                            .foregroundColor(.purple)
                            .font(.title)
                            .fontWeight(.semibold)
                            .scaledToFit()
                            .minimumScaleFactor(0.6)
                            .lineLimit(1)
                            .onLongPressGesture {
                                editName(player: "2")
                            }
                    } else {
                        HStack(alignment: .center, spacing: 5) {
                            TextField(player2Name, text: $player2Name)
                                .focused($isFocused)
                                .onSubmit {
                                    player2editingText = false
                                    isFocused = false
                                }
                                .frame(maxHeight: .infinity)
                                .background(Color(.white))
                                
                                .cornerRadius(5)
                                .padding()
                                .foregroundColor(.blue)
                                .font(.title)
                                
                            
                            Button {
                                player2editingText = false
                                isFocused = false
                            } label: {
                                Text("Save")
                                   
                                    .frame(minWidth: 50, maxHeight: .infinity)
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .padding([.top, .bottom, .trailing])
    
                            }
                            
                            
     
                        }
                        .fixedSize(horizontal: false, vertical: true)
                            
                    
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


struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        CentreView(player1editingText: false).background(Color.red).previewInterfaceOrientation(.portrait)
    }
}




