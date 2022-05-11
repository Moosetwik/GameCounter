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
    @State var gameTimeSeconds = 1800
    @State var originalTimeSeconds = 1800
    @State private var historyPresented = false
    @State private var settingsPresented = false
    @Binding var lifeLog: LifeHistory
    @State private var timerActionPresented = false
    @State private var timerPaused = true
    @State var countDownPresented = false
    @State var countingDown = true
    
    
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
                        
                        Text(timerPaused ? "Start timer" : "Pause timer")
                    }
                    
                    Button {
                        gameTimeSeconds = originalTimeSeconds
                    } label: {
                        Image(systemName: "clock.arrow.circlepath")
                        Text("Reset Timer")
                        
                    }
                    Button {
                        print("Custom Timer")
                        countDownPresented = true
                        
                        
                    } label: {
                        Image(systemName: "hourglass.bottomhalf.filled")
                            .foregroundColor(!countingDown ? .black : .red)
                        
                        Text("Custom Timer")
                    }
                    
                    
                } label: {
                    
                        
                        HStack{
                            Text(gameTimeSeconds.convertedTime)
                                .foregroundColor(timerPaused ? .red : .white)
                                .font(.title3)
                                .monospacedDigit()
                                .fixedSize()
                                .onAppear() {
                                    print("Clock Appeared")
                                   
                                    
                                }
                                .onReceive(self.timer) { _ in
                                    if !countingDown {
                                        gameTimeSeconds += 1
                                    } else {
                                        gameTimeSeconds -= 1
                                    }
                                }
                            
                            Image(systemName: (timerPaused ? "pause" : "clock"))
                                .aspectRatio(contentMode: .fill)
                                .animation(nil)
                                .foregroundColor(.white)
                            
                        }
                        
                    
                    
                    
                }
                .popover(isPresented: $countDownPresented) {
                    CountDownView(countDownSeconds: originalTimeSeconds, originalCountDownSeconds: $originalTimeSeconds, setCountDown: $gameTimeSeconds, countDownPresented: $countDownPresented, countingDown: $countingDown)
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

struct CountDownView: View {
    @State var countDownSeconds = 1800
    @Binding var originalCountDownSeconds: Int
    @Binding var setCountDown: Int
    @Binding var countDownPresented: Bool
    @Binding var countingDown: Bool
    
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .background(.clear)
                .foregroundColor(.white)
                .frame(width: 200, height: 200, alignment: .center)
            VStack(alignment: .center, spacing: 0) {
                Text("\(countDownSeconds.convertedTime)")
                    .font(.largeTitle)
                    .padding()
                
                Stepper("", value: $countDownSeconds, in: 30...7200, step: 300)
                .labelsHidden()
                Text("5 minutes")
                    .font(.caption2)
                    .padding(.bottom)
                
                Stepper("", value: $countDownSeconds, in: 30...7200, step: 30)
                .labelsHidden()
                
                Text("30 seconds")
                    .font(.caption)
                    .padding(.bottom)
                HStack(alignment: .center, spacing: 10) {
                    
                    Button {
                        countDownPresented = false
                        
                    } label: {
                        Text("Cancel")
                    }
                    .foregroundColor(.red)
                    Button {
                        countDownPresented = false
                        setCountDown = countDownSeconds
                        originalCountDownSeconds = countDownSeconds
                        countingDown = true
                    } label: {
                        Text("Set Timer")
                            .padding(3.0)
                        
                    }
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.932, green: 0.932, blue: 0.935)/*@END_MENU_TOKEN@*/)
                    .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                    
                    
                }
                .padding()
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

struct CentreView_PreviewContainer: View {
    @State var placeHolderBool = true
    @State var placeHolderInt = 600
    @State var lifeHistory = LifeHistory(lifeLogP1: [5], damageTakenP1: [5], lifeLogP2: [5], damageTakenP2: [5])
    var body: some View {
        Group {
        CountDownView(countDownSeconds: 600, originalCountDownSeconds: $placeHolderInt, setCountDown: $placeHolderInt, countDownPresented: $placeHolderBool, countingDown: $placeHolderBool)
            
            CentreView(lifeLog: $lifeHistory)
        }
    }
}

struct CentreView_Preview: PreviewProvider {
    
    static var previews: some View {
        CentreView_PreviewContainer().previewLayout(.fixed(width: 200, height: 300))
    }
}




