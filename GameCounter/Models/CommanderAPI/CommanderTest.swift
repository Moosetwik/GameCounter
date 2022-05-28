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
    @State private var searchTExt = ""

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
    
    var body: some View {
 
        List(datas.commanders) { commander in
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text(commander.name)
                    .font(.subheadline)
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                
                HStack(spacing: 0){
                    ForEach(commander.colorIdentity, id: \.self) { i in
                        
                        ZStack {
                            Rectangle()
                                .frame(height: 16)
                            Rectangle()
                                .frame(height: 10)
                            .foregroundColor(convertColor(input: i))
                        }
                    }
                }

            }
        }
    }
}

struct Test_Preview: PreviewProvider {
    static var previews: some View {
        Test_View().previewLayout(.sizeThatFits)
    }
}

