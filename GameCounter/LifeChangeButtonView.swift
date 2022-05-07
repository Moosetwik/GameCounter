//
//  ButtonView.swift
//  GameCounter
//
//  Created by Nick Jones on 11/4/2022.
//

import SwiftUI
import Combine



struct LifeChangeButtonView: View, Identifiable {
    
    
    var id = UUID()
    @Binding var lifeTotal: Int
    
    @State private var positiveTapped = false
    @State private var negativeTapped = false
    @State private var captureBegan = false
    @State var damage = 0
    @Binding var damageTaken: [Int]
    @Binding var lifeLog: [Int]
    
    
    var timer = GameTime()
    
    @State var secondsElapsed = 0
    @State var timerRunning = false
   

    @State var p1Timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State var p1connectedTimer: Cancellable? = nil
    
    func instantiateTimer() {
        self.p1Timer = Timer.publish(every: 0.5, on: .main, in: .common)
        self.p1connectedTimer = p1Timer.connect()
        return
    }
    
    func cancelTimer() {
        self.p1connectedTimer?.cancel()
        
        return
    }
    
    func restartTimer() {
        self.secondsElapsed = 0
        self.cancelTimer()
        self.instantiateTimer()
        return
    }
    
   
    func captureLife() -> Int {
        
        return 0
    }
    
    func buttonTapped(isPositive: Bool) {

        if !captureBegan {
            
            self.instantiateTimer()
            damage = 0
            self.captureBegan = true
            print("Timer started")
            
        } else {
            self.restartTimer()
            print("Timer restarted")
        }

        if isPositive {
            self.positiveTapped = true
            damage += 1
            lifeTotal += 1

        } else {
            self.negativeTapped = true
            damage -= 1
            lifeTotal -= 1
        }
        
        print("\(damage)")
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { _ in
            
            self.positiveTapped = false
            self.negativeTapped = false
            
        })

    }
    

    var body: some View {
        
        ZStack {
            HStack(spacing: 0.0) {
                Button {
                    buttonTapped(isPositive: false)
                } label: {
                    Text("")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            
                            Color(negativeTapped ? .white : .clear)
                                .animation(.easeInOut(duration: 0.1))
                            
                                .opacity(0.15))
    
                }

                Button {
                    self.buttonTapped(isPositive: true)
                } label: {
                    Text("")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            
                            Color(positiveTapped ? .white : .clear)
                                .animation(.easeInOut(duration: 0.1))
                            
                                .opacity(0.15))
  
                }
                
            }
        }
        .onReceive(self.p1Timer) { _ in
            if damage != 0 {
                self.damageTaken.append(damage)
            }
            print("\(damageTaken)")
            damage = 0
            lifeLog.append(lifeTotal)
            
            self.cancelTimer()
            print("Timer ended")
            print("Log: \(lifeLog)")
            
        }
        
        
    }
    
    
}



