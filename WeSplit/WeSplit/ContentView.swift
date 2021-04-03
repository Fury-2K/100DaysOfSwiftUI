//
//  ContentView.swift
//  WeSplit
//
//  Created by Manas Aggarwal on 03/04/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var billAmount: String = ""
    @State private var numberOfPeople: Int = 2
    @State private var selectedTipPercent: Int = 2
    
    private var tipPercent: [Int] = [0, 5, 10, 15, 20]
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Bill amount", text: $billAmount)
                        .keyboardType(.decimalPad)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percent", selection: $selectedTipPercent) {
                        ForEach(0 ..< tipPercent.count) {
                            Text("\(tipPercent[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Summary")) {
                    Text("Cheque Amount is ₹\(billAmount)")
                    Text("Tip is \(tipPercent[selectedTipPercent])%")
                    Text("To be split among \(numberOfPeople + 2) people")
                }
                Section {
                    Text("Per person = ₹\(perPersonCost, specifier: "%0.2f")")
                }
            }
            .navigationBarTitle("WeSplit", displayMode: .large)
        }
    }
    
    private var perPersonCost: Double {
        guard let total = Double(billAmount) else { return 0.0 }
        let tip: Double = total / 100 * Double(tipPercent[selectedTipPercent])
        let people: Double = Double(numberOfPeople + 2)
        return (total + tip) / people
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
