//
//  PolygonWithLinesVertexToVertex.swift
//  SwiftUI Animations
//
//  Created by 陆凯伦 on 2021/9/2.
//

import SwiftUI

struct PolygonWithLinesVertexToVertex: View {
    @State private var sides = 4
    
    var body: some View {
        VStack {
            PolygonShape(sides: sides)
                .stroke(Color.pink, lineWidth: 3)
                .padding(20)
                .animation(.easeInOut(duration: 3))
                .layoutPriority(1)
            Text("\(Int(sides)) Sides").font(.headline)
            HStack(spacing: 20) {
                GreenButton(label: "1") { sides = 1 }
                GreenButton(label: "3") { sides = 3 }
                GreenButton(label: "7") { sides = 7 }
            }
            HStack(spacing: 20) {
                GreenButton(label: "30") { sides = 30 }
                GreenButton(label: "+") { sides += 1 }
                GreenButton(label: "-") { sides = max(sides - 1, 1) }
            }
        }
        .navigationBarTitle("Polygon with Lines Vertex-to-vertex")
    }
}

struct PolygonWithLinesVertexToVertex_Previews: PreviewProvider {
    static var previews: some View {
        PolygonWithLinesVertexToVertex()
    }
}

private struct PolygonShape: Shape {
    var sides: Int
    private var sidesAsDouble: Double
    
    var animatableData: Double {
        get { sidesAsDouble }
        set { sidesAsDouble = newValue }
    }
    
    init(sides: Int) {
        self.sides = sides
        self.sidesAsDouble = Double(sides)
    }
    
    func path(in rect: CGRect) -> Path {
        let hypotenuse = Double(min(rect.size.width, rect.size.height)) / 2.0
        let center = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
        var path = Path()
        let extra = Double(sidesAsDouble) != Double(Int(sidesAsDouble)) ? 1 : 0
        for index in 0..<Int(sidesAsDouble) + extra {
            let angle = (Double(index) * (360.0 / Double(sidesAsDouble))) * Double.pi / 180
            let point = CGPoint(x: center.x + CGFloat(cos(angle) * hypotenuse), y: center.y + CGFloat(sin(angle) * hypotenuse))
            if index == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        path.closeSubpath()
        return path
    }
}
