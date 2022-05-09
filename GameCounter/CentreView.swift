//
//  CentreView.swift
//  GameCounter
//
//  Created by Nick Jones on 11/4/2022.
//

import SwiftUI
import Combine

struct CentreView: View {
    
    var gameTime = GameTime()
    @State var gameTimeSeconds = 0
    @State private var historyPresented = false
    @State private var settingsPresented = false
    @Binding var lifeLog: LifeHistory
    @State private var timerActionPresented = false
    @State private var timerPaused = false
    
    
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State var connectedTimer: Cancellable? = nil
    
    func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
        connectedTimer = timer.connect()
    }
    
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
                
                Menu {
                    
                    Button {
                        print("Pause Timer")
                        
                        if !timerPaused {
                        gameTime.cancelTimer(timerType: connectedTimer!)
                        timerPaused = true
                        } else {
                            startTimer()
                            timerPaused = false
                        }
                    } label: {
                        Image(systemName: (timerPaused ? "play.circle" : "pause.circle"))
                            
                        Text(timerPaused ? "Resume timer" : "Pause timer")
                    }

                    Button {
                        gameTimeSeconds = 0
                    } label: {
                        Image(systemName: "clock.arrow.circlepath")
                        Text("Reset Timer")
                        
                    }
                    Button {
                        print("Custom Timer")
                    } label: {
                        Image(systemName: "hourglass.bottomhalf.filled")
                        Text("Set Countdown Timer")
                    }
                } label: {
                    ZStack{
                        Text(gameTimeSeconds.convertedTime)
                            .foregroundColor(timerPaused ? .red : .white)
                        .font(.title2)
                        .monospacedDigit()
                        .fixedSize()
                        .onAppear() {
                            print("Clock Appeared")
                            startTimer()
                            
                        }
                        .onReceive(self.timer) { _ in
                            gameTimeSeconds += 1
                        }
                        HStack{
                            
                        Image(systemName: (timerPaused ? "pause" : "clock"))
                                .fixedSize()
                                .animation(nil)
                        .foregroundColor(.white)
                            
                        }
                        .padding(.leading, 75)
                    }
                    
                }
                
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





