//
//  ButtonView.swift
//  GameCounter
//
//  Created by Nick Jones on 11/4/2022.
//

import SwiftUI
import Combine



struct LifeChangeButtonView: View {
    
    @Binding var lifeTotal: Int
    @State private var positiveTapped = false
    @State private var negativeTapped = false
    @State private var captureBegan = false
    @State var damage = 0
    @Binding var damageTaken: [Int]
    @Binding var lifeLog: [Int]
    @State var posTouchdown = false
    @State var negTouchdown = false
    @Binding var rotation: Double
    @Binding var rotated: Int
    @ObservedObject var settings: Settings
    @Binding var isRotated: Bool
    var timer = GameTime()
    
    @State var secondsElapsed = 0
    @State var timerRunning = false
   

    @State var p1Timer: Timer.TimerPublisher = Timer.publish(every: 3, on: .main, in: .common)
    @State var p1connectedTimer: Cancellable? = nil
    
    func instantiateTimer() {
        self.p1Timer = Timer.publish(every: 3, on: .main, in: .common)
        self.p1connectedTimer = p1Timer.connect()
        return
    }

    func restartTimer() {
        self.secondsElapsed = 0
        self.timer.cancelTimer(timerType: p1connectedTimer!)
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
    
    enum ButtonTap {
        case positive, negative
    }
    
    
    
    
    var body: some View {
        ZStack {
            
            AdaptiveView(threshold: isRotated, spacing: 0) {
                    Rectangle()
                        .foregroundColor(!negTouchdown ? .white.opacity(0.01) : .white.opacity(0.5))
                        .gesture(DragGesture(minimumDistance: 0)
                            .onChanged({ _ in
                                negTouchdown = true
                            })
                                .onEnded({ _ in
                                    negTouchdown = false
                                    buttonTapped(isPositive: false)
                                })
                    )
                    
                    Rectangle()
                        .foregroundColor(!posTouchdown ? .white.opacity(0.01) : .white.opacity(0.5))
                        .gesture(DragGesture(minimumDistance: 0)
                            .onChanged({ _ in
                                posTouchdown = true
                            })
                                .onEnded({ _ in
                                    posTouchdown = false
                                    buttonTapped(isPositive: true)
                                })
                    )
                }
            .rotationEffect(.degrees(rotated == 2 ? 180 : rotated == 3 ? 180 : 0))
                    VStack{
                    if settings.bannerVisible {
                            Spacer()
                            BannerView()
                            .padding(50)
                    }
                    }
                    .rotationEffect(.degrees(rotation))
                    .animation(.spring(), value: rotation)
        }
        .onReceive(self.p1Timer) { _ in
            if damage != 0 {
                self.damageTaken.append(damage)
                lifeLog.append(lifeTotal)
            }
            print("\(damageTaken)")
            damage = 0
            
            
            self.timer.cancelTimer(timerType: p1connectedTimer!)
            print("Timer ended")
            print("Log: \(lifeLog)")
            
        }
        
        
        
        
    }
    
    
}


