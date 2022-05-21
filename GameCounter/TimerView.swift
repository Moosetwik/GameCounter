//
//  TimerView.swift
//  GameCounter
//
//  Created by Nick Jones on 14/5/2022.
//

import SwiftUI
import Combine

struct TimerView: View {
    
    var gameTime = GameTime()
    @State var gameTimeSeconds = 1800
    @State var originalTimeSeconds = 1800
    
    @State private var timerActionPresented = false
    @State private var timerPaused = true
    @State var countDownPresented = false
    @State var countingDown = true
    @State var timerCompletion = 1.0
    
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State var connectedTimer: Cancellable? = nil
   
    
    @Binding var timerSize: CGFloat
    @Binding var strokeSize: CGFloat
    
    func convertTimer() -> Double {
        var calculatedValue = 0.0
        calculatedValue = 1 / Double(originalTimeSeconds)
        return calculatedValue
    }
    
    
    func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
        connectedTimer = timer.connect()
        timerPaused = false
    }
    
    func resetTimer() {
        
        withAnimation {
        timerCompletion += (1.0 - timerCompletion)
        }
        gameTimeSeconds = originalTimeSeconds
        if !timerPaused {
            gameTime.cancelTimer(timerType: connectedTimer!)
        }
      
        
          timerCompletion += (1.0 - timerCompletion)
        
        timerPaused = true
    }
    
    func pauseTimer() {
        
        gameTime.cancelTimer(timerType: connectedTimer!)
        timerPaused = true
    }
    
    var body: some View {
        
        ZStack{
            Menu {
                Button {
                    resetTimer()
                    
                } label: {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("Reset Timer")
                }
                Button {
                    print("Custom Timer")
                    if !timerPaused {
                        pauseTimer()
                    }
                    countDownPresented = true
                } label: {
                    Image(systemName: "hourglass.bottomhalf.filled")
                    Text("Custom Timer")
                }

            } label: {

                ZStack{
                    
                   
                    Circle()
                        .trim(from: 0.0, to: timerCompletion)
                        .stroke(.gray, lineWidth: strokeSize)
                        .rotationEffect(.degrees(270))
                        .frame(width: timerSize, height: timerSize, alignment: .center)
                    
                    
                    Image(systemName: "pause.fill")
                            .font(.system(size: 75))
                            .foregroundColor(timerPaused ? (.white.opacity(0.25)) : (.white.opacity(0.0)))
         
                    Text(gameTimeSeconds.convertedTime)
                        .foregroundColor(timerPaused ? .red : .gray)
                        .font(.title)
                        .fontWeight(.bold)
                        .monospacedDigit()
                        .fixedSize()
                        .onReceive(self.timer) { _ in
                            withAnimation {
                                if gameTimeSeconds > 0 {
                                    gameTimeSeconds -= 1
                                    timerCompletion -= convertTimer()
                                    print(timerCompletion)
                                }
                            }
                        }
                    
                }
                
                
                
            } primaryAction: {
                timerPaused ? startTimer() : pauseTimer()
            }
            
            
            
        }
        .popover(isPresented: $countDownPresented) {
            CountDownView(countDownSeconds: originalTimeSeconds, originalCountDownSeconds: $originalTimeSeconds, setCountDown: $gameTimeSeconds, countDownPresented: $countDownPresented, countingDown: $countingDown, timerCompletion: $timerCompletion)
        }
    }
}

struct CountDownView: View {
    
    @State var countDownSeconds = 1800
    @Binding var originalCountDownSeconds: Int
    @Binding var setCountDown: Int
    @Binding var countDownPresented: Bool
    @Binding var countingDown: Bool
    @Binding var timerCompletion: Double
    
    
    var body: some View {
        
        ZStack {
            
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
                        timerCompletion = 1.0
                        
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




struct CentreView_PreviewContainer: View {
    @State var placeHolderBool = true
    @State var placeHolderInt = 600
    @State var placeHolderDouble = 600.0
    @State var lifeHistory = LifeHistory(lifeLogP1: [5], damageTakenP1: [5],
                                         lifeLogP2: [5], damageTakenP2: [5])
    
    var body: some View {
        Group {
            CountDownView(countDownSeconds: 600, originalCountDownSeconds: $placeHolderInt, setCountDown: $placeHolderInt, countDownPresented: $placeHolderBool, countingDown: $placeHolderBool, timerCompletion: $placeHolderDouble)
            
            
            
        }
    }
}

struct CentreView_Preview: PreviewProvider {
    
    static var previews: some View {
        Group {
        CentreView_PreviewContainer().previewLayout(.fixed(width: 200, height: 300))
            
        }
    }
}

