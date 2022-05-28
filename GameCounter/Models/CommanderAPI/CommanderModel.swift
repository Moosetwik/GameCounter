//
//  CommanderModel.swift
//  GameCounter
//
//  Created by Nick Jones on 27/5/2022.
//

import Foundation
import Combine

struct Commander: Codable, Identifiable {
    let id, name: String
        let colorIdentity: [String]

        enum CodingKeys: String, CodingKey {
            case id, name
            case colorIdentity = "color_identity"
        }
}


class ReadData: ObservableObject  {
    @Published var commanders = [Commander]()

    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "commander", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        
        let data = try? Data(contentsOf: url)
        let commanders = try? JSONDecoder().decode([Commander].self, from: data!)
        self.commanders = commanders!
        
    }
     
}
