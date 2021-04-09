//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Manas Aggarwal on 08/04/21.
//

import SwiftUI

struct ContentView: View {
    // View as stored property
    let someText = Text("F")
    
    // View as computed property
    var uselessButton: some View {
        Button("Button") {
            print(type(of: self.body))
        }
    }
    
    var body: some View {
        VStack {
            uselessButton
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.red)
                
            uselessButton
            .frame(maxWidth: 100, maxHeight: .infinity)
            .background(Color.red)
            
            VStack {
                Text("Gryffindor")
                    .font(.largeTitle)
                Text("Hufflepuff")
                Text("Ravenclaw")
                Text("Slytherin")
            }
            .font(.title)
            
            VStack {
                CapsuleText(text: "Gryffindor")
                CapsuleText(text: "Hufflepuff")
                CapsuleText(text: "Ravenclaw")
                CapsuleText(text: "Slytherin")
            }
            
            Color.blue
                .frame(width: 300, height: 200)
                .watermarked(with: "Hacking with Swift")
        }
//        .edgesIgnoringSafeArea(.all)
    }
}

// MARK:- Separate view

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

// MARK: - View Modifiers

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
