//
//  CommanderModel.swift
//  GameCounter
//
//  Created by Nick Jones on 27/5/2022.
//

import Foundation
import Combine

struct Response: Codable {
    var data: [Result]
}

struct Result: Codable, Hashable {
    var name: String = ""
    var id: String = ""
    var type_line: String = ""
    var color_identity: [String] = [""]
}
