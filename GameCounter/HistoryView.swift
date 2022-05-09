//
//  HistoryView.swift
//  GameCounter
//
//  Created by Nick Jones on 7/5/2022.
//

import SwiftUI

struct HistoryView: View {
    
    
    @Binding var historyPresented: Bool
    @Binding var lifeLog: LifeHistory
    
    
    var body: some View {
        NavigationView {
            
            HStack {
                //Player 1 Life History
                VStack {
                    Text("Player 1")
                    List() {
                       
                        
                        Section(header:
                                    HStack{
                            Text("Life Total")
                            Spacer()
                            Text("Damage Taken")
                        }
                        ) {
                            ForEach(Array(lifeLog.lifeLogP1.enumerated()), id: \.0) { index, item in
                            HistoryCell(lifeLog: item, damageTaken: lifeLog.damageTakenP1[index])
                        }
                        }
                        
                    
                    }
                }
                
                //Player 2 Life History
                
                VStack {
                    Text("Player 2")
                    List() {
                       
                        
                        Section(header:
                                    HStack{
                            Text("Life Total")
                            Spacer()
                            Text("Damage Taken")
                        }
                        ) {
                            ForEach(Array(lifeLog.lifeLogP2.enumerated()), id: \.0) { index, item in
                            HistoryCell(lifeLog: item, damageTaken: lifeLog.damageTakenP2[index])
                        }
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
        
    }
}



struct HistoryCell: View {
    var lifeLog: Int
    var damageTaken: Int
    
    var body: some View {
        
        HStack{
            Text("\(lifeLog)")
                .font(.title2)
                .lineLimit(1)
                
            Spacer()
            
            Text(damageTaken > 0 ? "+\(damageTaken)" : "\(damageTaken)")
                .font(.title2)
                
        }
        .padding()
    }
}

struct HistoryCell_Preview: PreviewProvider {
    static var previews: some View {
        HistoryCell(lifeLog: 25, damageTaken: 5).previewLayout(.sizeThatFits)
    }
}

