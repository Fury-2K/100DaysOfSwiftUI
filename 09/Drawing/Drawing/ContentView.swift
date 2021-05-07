//
//  ContentView.swift
//  Drawing
//
//  Created by Manas Aggarwal on 02/05/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Path { path in
//            path.move(to: CGPoint(x: 200, y: 100))
//            path.addLine(to: CGPoint(x: 100, y: 300))
//            path.addLine(to: CGPoint(x: 300, y: 300))
//            path.addLine(to: CGPoint(x: 200, y: 100))
            
            path.move(to: CGPoint(x: 100, y: 100))
            path.addLine(to: CGPoint(x: 300, y: 100))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 200))
            path.addLine(to: CGPoint(x: 100, y: 300))
            path.addLine(to: CGPoint(x: 100, y: 100))
        }
        .stroke(Color.blue, lineWidth: 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
