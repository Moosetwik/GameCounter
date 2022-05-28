//
//  CommanderTest.swift
//  GameCounter
//
//  Created by Nick Jones on 27/5/2022.
//

import Foundation
import SwiftUI

struct Test_View: View {
    @ObservedObject var datas = ReadData()
    @State private var searchText = ""
    @Binding var historyPresented: Bool
    @Binding var commanderName: String
   
    

    func convertColor(input: String) -> Color {
        var output = Color.white
        
        switch input {
        case "W":
            output = .white
        case "R":
            output = .red
        case "B":
            output = .black
        case "U":
            output = .blue
        case "G":
            output = .green
        default: break
        }
        
        return output
    }
    
    var commanders: [Commander] {
        if searchText.isEmpty {
        return datas.commanders
        } else {
            return datas.commanders.filter {names in names.name.contains(searchText)}
        }
    }
    
    var searchResults: [String] {
        var names = [String]()
        for name in commanders {
            names.append(name.name)
        }
        
        if searchText.isEmpty {
            return names
        } else{
            return names.filter {$0.contains(searchText)}
        }
    }
    
    var colorIds: [[String]] {
        var colors = [[String]]()
        for color in datas.commanders {
            colors.append(color.colorIdentity)
        }
        return colors
    }
    
    var body: some View {
        NavigationView{
            List {
                ForEach(commanders, id: \.self) { names in
                    
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 5) {

                            Text(names.name)
                            
                            HStack(alignment: .center, spacing: 5) {
                                ForEach(names.colorIdentity, id: \.self) { colours in
                                    Rectangle()
                                        .frame(width: 50, height: 5)
                                        .foregroundColor(convertColor(input: colours))
                                }
                                
                               

                    
                            }
                        }
                        Spacer()
                        Button {
                            commanderName = names.name
                            historyPresented = false
                        } label: {
                            Text("Select")
                        }
                    }
                    
                }
        }
        
        .navigationTitle("Player 1 Commander")
        .navigationBarItems(trailing: Button("Done") {
            historyPresented = false
        })
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))

            
    }
    

}

