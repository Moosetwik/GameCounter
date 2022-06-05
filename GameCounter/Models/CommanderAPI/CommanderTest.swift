//
//  CommanderTest.swift
//  GameCounter
//
//  Created by Nick Jones on 27/5/2022.
//

import Foundation
import SwiftUI

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

struct CommanderListView: View {

    @State private var searchText = ""
    @Binding var commanderViewPresented: Bool
    @Binding var commanderName: String
    @Binding var commanderColours: [String]
    
    @State private var results = [Result]()
    @State private var tempResults = [Result]()
    @State private var pageNumber = 0
    @State var taskLoading = true
    @State var taskProgress = 0.0
    
    func loadData(page: Int) async {
        while pageNumber < 8 {
            pageNumber += 1
            taskProgress += 0.125
        guard let url = URL(string: "https://api.scryfall.com/cards/search?format=json&;include_extras=false&include_multilingual=false&order=name&page=\(pageNumber)&q=legal%3Acommander+is%3Acommander&unique=cards") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                tempResults = decodedResponse.data
                results += tempResults
                print("Page: \(pageNumber), page results: \(tempResults.count)")
                print("Total results: \(results.count)")
                tempResults.removeAll()

            }

        } catch {
            results = [Result(name: "Failed to load list", id: "", type_line: "Please check your connection", color_identity: [""])]
        }
        }
       
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
 
            if taskLoading {
                LoadingView(taskProgress: $taskProgress)
                    .navigationTitle("Player 1 Commander")
                    
            } else {
            List {
                ForEach(commanders, id: \.self) { names in
                    
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 5) {

                            Text(names.name)
                                .font(.headline)
                            Text(names.type_line)
                                .font(.caption)
                                
                            
                            HStack(alignment: .center, spacing: 5) {
                                ForEach(names.color_identity, id: \.self) { colours in
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.black, lineWidth: 1)
                                        .background(
                                            RoundedRectangle(cornerRadius: 5)
                                                .foregroundColor(convertColor(input: colours))
                                        )
                                        .frame(width: 30, height: 5)
                                        
                                        
                                        
                                }
 
                            }
                            .padding(.top, 5)
                        }
                        Spacer()
                        Button {
                            commanderName = names.name
                            commanderColours = names.color_identity
                            commanderViewPresented = false
                        } label: {
                            Text("Select")
                        }
                    }
                    
                }
        }
            .navigationTitle("Player 1 Commander")
            .toolbar {
                Button("Done") {
                    commanderViewPresented = false
                }
            }
            
            
            }
        }
        
        .task {
            await loadData(page: pageNumber)
            taskLoading = false
        }
        
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        
        

            
    }
    

}

struct LoadingView: View {
    @Binding var taskProgress: Double
    var body: some View {
        
        VStack(alignment: .center, spacing: 10) {
            Text("Loading Commanders...")
                .font(.subheadline)
                .disabled(true)
            ProgressView(value: taskProgress)
                .animation(.easeInOut, value: taskProgress)
        }
        .padding(100)
    }
}
