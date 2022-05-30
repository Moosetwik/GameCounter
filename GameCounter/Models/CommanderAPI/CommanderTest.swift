//
//  CommanderTest.swift
//  GameCounter
//
//  Created by Nick Jones on 27/5/2022.
//

import Foundation
import SwiftUI

struct Test_View: View {

    @State private var searchText = ""
    @Binding var historyPresented: Bool
    @Binding var commanderName: String
    
    @State private var results = [Result]()
    @State private var tempResults = [Result]()
    @State private var pageNumber = 0
    
    func loadData(page: Int) async {
        while pageNumber < 8 {
            pageNumber += 1
        guard let url = URL(string: "https://api.scryfall.com/cards/search?format=json&;include_extras=false&include_multilingual=false&order=name&page=\(pageNumber)&q=legal%3Acommander+is%3Acommander&unique=cards") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, meta) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                tempResults = decodedResponse.data
                results += tempResults
                print("Page: \(pageNumber), page results: \(tempResults.count)")
                print("Total results: \(results.count)")
                tempResults.removeAll()

            }

        } catch {
            print("Invalid data")
        }
        }
       
    }
   
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
    
    var commanders: [Result] {
        if searchText.isEmpty {
        return results
        } else {
            return results.filter { names in
                names.name.contains(searchText)}
    }
    }
    
    
    var colorIds: [[String]] {
        var colors = [[String]]()
        for color in results {
            colors.append(color.color_identity)
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
                                .font(.headline)
                            Text(names.type_line)
                                .font(.subheadline)
                                
                            
                            HStack(alignment: .center, spacing: 5) {
                                ForEach(names.color_identity, id: \.self) { colours in
                                    Rectangle()
                                        .frame(width: 50, height: 5)
                                        .foregroundColor(convertColor(input: colours))
                                }
 
                            }
                            .padding(.top, 5)
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
        .task {
            await loadData(page: pageNumber)
        }
        
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))

            
    }
    

}

