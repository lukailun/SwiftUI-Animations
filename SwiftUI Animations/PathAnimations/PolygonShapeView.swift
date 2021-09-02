//
//  PolygonShapeView.swift
//  SwiftUI Animations
//
//  Created by 陆凯伦 on 2021/9/1.
//

import SwiftUI

struct PolygonShapeView: View {
    @State private var sides: Double = 4
    
    var body: some View {
        VStack {
            PolygonShape(sides: sides)
                .stroke(Color.blue, lineWidth: 3)
                .padding(20)
                .animation(.easeInOut(duration: 1.75))
                .layoutPriority(1)
            Text("\(Int(sides)) sides").font(.headline)
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
            .navigationBarTitle("Example 1")
            .padding(.bottom, 50)
        }
    }
}

struct PolygonShapeView_Previews: PreviewProvider {
    static var previews: some View {
        PolygonShapeView()
    }
}

private struct PolygonShape: Shape {
    var sides: Double
    
    var animatableData: Double {
        get { return sides }
        set { sides = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let hypotenuse = Double(min(rect.size.width, rect.size.height)) / 2.0
        let center = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
        var path = Path()
        let extra = Double(sides) != Double(Int(sides)) ? 1 : 0
        for index in 0..<Int(sides) + extra {
            let angle = (Double(index) * (360.0 / Double(sides))) * Double.pi / 180
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
