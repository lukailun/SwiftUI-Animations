//
//  GreenButton.swift
//  SwiftUI Animations
//
//  Created by 陆凯伦 on 2021/9/2.
//

import SwiftUI

struct GreenButton: View {
    let label: String
    let action: () -> ()
    
    var body: some View {
        Button(action: { action() },
               label: {
                Text(label)
                    .font(.title)
                    .padding(10)
                    .frame(width: 70)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.green).shadow(radius: 2))
                    .foregroundColor(.white)
               })
    }
}

struct GreenButton_Previews: PreviewProvider {
    static var previews: some View {
        GreenButton(label: "Button", action: {})
    }
}
