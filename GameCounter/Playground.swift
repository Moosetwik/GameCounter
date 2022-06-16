//
//  Playground.swift
//  GameCounter
//
//  Created by Nick Jones on 29/5/2022.
//

import SwiftUI



struct AdaptiveView<Content: View>: View {

    var threshold: Bool
    var spacing: CGFloat
    var content: Content

  public init(
    threshold: Bool,
    spacing: CGFloat,
    @ViewBuilder content: () -> Content
  ) {
    self.threshold = threshold
    self.spacing = spacing
    self.content = content()
  }

  var body: some View {
    ZStack {
      if threshold {
          HStack(spacing: spacing) {
          content
        }
      } else {
          VStack(spacing: spacing) {
          content
        }
      }
    }
  }
}




struct PlayerX: Identifiable {
    let id = UUID()
    var name: String
}

class Test: ObservableObject {
    @Published var players = [PlayerX]()
    
}

struct Playground: View {
   @ObservedObject var test = Test()
    var body: some View {
       Text("dmbkb")
        }
}


struct Playground_Previews: PreviewProvider {
    static var previews: some View {
        Playground().previewLayout(.sizeThatFits)
            .padding(20)
    }
}

