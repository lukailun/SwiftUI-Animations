//
//  PolygonWithMultipleAnimatableParamters.swift
//  SwiftUI Animations
//
//  Created by 陆凯伦 on 2021/9/2.
//

import SwiftUI

struct PolygonWithMultipleAnimatableParamters: View {
    @State private var sides = 4
    @State private var scale = 1.0
    
    var body: some View {
        VStack {
            PolygonShape(sides: sides, scale: scale)
                .stroke(Color.blue, lineWidth: 3)
                .padding(20)
                .animation(.easeInOut(duration: 1.75))
                .layoutPriority(1)
            Text("\(Int(sides)) Sides, \(String(format: "%.2f", scale)) Scale").font(.headline)
            HStack(spacing: 20) {
                GreenButton(label: "1") {
                    sides = 1
                    scale = 1
                }
                GreenButton(label: "3") {
                    sides = 3
                    scale = 0.7
                }
                GreenButton(label: "7") {
                    sides = 7
                    scale = 0.3
                }
            }
            HStack(spacing: 20) {
                GreenButton(label: "30") {
                    sides = 30
                    scale = 1
                }
                GreenButton(label: "+") {
                    sides += 1
                    scale = min(scale * 2, 1)
                }
                GreenButton(label: "-") {
                    sides = max(sides - 1, 1)
                    scale = min(scale / 2, 1)
                }
            }
        }
        .navigationBarTitle("Polygon with Multiple Animatable Paramters")
    }
}

struct PolygonWithMultipleAnimatableParamters_Previews: PreviewProvider {
    static var previews: some View {
        PolygonWithMultipleAnimatableParamters()
    }
}

private struct PolygonShape: Shape {
    var sides: Int
    var scale: Double
    private var sidesAsDouble: Double
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(sidesAsDouble, scale) }
        set {
            sidesAsDouble = newValue.first
            scale = newValue.second
        }
    }
    
    init(sides: Int, scale: Double) {
        self.sides = sides
        self.scale = scale
        self.sidesAsDouble = Double(sides)
    }
    
    func path(in rect: CGRect) -> Path {
        let hypotenuse = Double(min(rect.size.width, rect.size.height)) / 2.0 * scale
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
