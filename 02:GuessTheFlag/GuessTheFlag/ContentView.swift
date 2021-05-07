//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Manas Aggarwal on 04/04/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showScore: Bool = false
    @State private var scoreTitle: String = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score: Int = 0
    @State private var scoreBody: String = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.gray, Color.blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            VStack(spacing: 32) {
                Text("Select correct flag of \(countries[correctAnswer])")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .multilineTextAlignment(.center)
                
                ForEach(0..<3) { number in
                    Button(action: {flagTapped(at: number)}) {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 0.5))
                            .shadow(color: .black, radius: 2)
                    }
                    .cornerRadius(10)
                }
                
                Text("Current Score: \(score)")
                    .font(.title2)
                    .shadow(radius: 10)
            }.padding()
            .alert(isPresented: $showScore) {
                Alert(title: Text(scoreTitle), message: Text(scoreBody), dismissButton: .default(Text("Continue")) {
                    askQuestion()
                })
            }
        }
    }
    
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    private func flagTapped(at index: Int) {
        if index == correctAnswer {
            score += 10
            scoreTitle = "Correct"
            scoreBody = "You are so pro <3. Your score is \(score)"
        } else {
            scoreTitle = "Wrong"
            scoreBody = "Booo! Loser; This is the flag of \(countries[index])"
        }
        showScore = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
