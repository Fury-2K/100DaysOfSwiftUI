//
//  GradientExample.swift
//  GuessTheFlag
//
//  Created by Manas Aggarwal on 04/04/21.
//

import SwiftUI

struct GradientExample: View {
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
            RadialGradient(gradient: Gradient(colors: [Color.gray, Color.green]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startRadius: 100, endRadius: 200)
            AngularGradient(gradient: Gradient(colors: [Color.red, Color.blue]), center: .center, startAngle: .degrees(-170), endAngle: .degrees(10))
        }
    }
}

struct GradientExample_Previews: PreviewProvider {
    static var previews: some View {
        GradientExample()
    }
}
