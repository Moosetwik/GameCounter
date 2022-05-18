//
//  Shapes.swift
//  GameCounter
//
//  Created by Nick Jones on 15/5/2022.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct Shapes: View {
    var body: some View {
        
       Triangle()
            .foregroundColor(.red)
            .frame(width: 100, height: 100, alignment: .center)
            .background(Color.black)
    }
}

struct Shapes_Previews: PreviewProvider {
    static var previews: some View {
        Shapes().previewDevice("iPhone 12 Pro")
    }
}
