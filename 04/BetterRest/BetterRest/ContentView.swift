//
//  ContentView.swift
//  BetterRest
//
//  Created by Manas Aggarwal on 13/04/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount: Double = 8.0
    @State private var wakeUp: Date = Date()
    @State private var coffeeAmount = 1
    @State private var showResult: Bool = false
    
    @State private var alertTitle: String = ""
    @State private var alertMessageText: String = ""
    @State private var dismissButtonText: String = ""
    
    private var model = SleepCalculator()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Data input")) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("When do you want to wake up?")
                            .font(.headline)
                        DatePicker("Wake up", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                    }
                     
                    VStack(alignment: .leading, spacing: 4) {
                        Text("What is the amount of sleep you want?")
                            .font(.headline)
                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                            Text(
                                "\(sleepAmount, specifier: "%g") hours")
                        }
                    }
                     
                    VStack(alignment: .leading, spacing: 4) {
                        Text("How much coffee do you drink?")
                            .font(.headline)
                        Stepper(value: $coffeeAmount, in: 1...10) {
                            Text(
                                "\(coffeeAmount) \(coffeeAmount == 1 ? "cup" : "cups") of coffee")
                        }
                    }
                }
            }
            .navigationBarTitle("BetterRest", displayMode: .large)
            .navigationBarItems(trailing:
                Button("Calculate") {
                    calculateBedtime()
                }
            )
            .alert(isPresented: $showResult) {
                Alert(title: Text(alertTitle), message: Text(alertMessageText), dismissButton: .default(Text(dismissButtonText)))
            }
        }
    }
    
    private func calculateBedtime() {
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hours = components.hour ?? 0 * 3600
        let minutes = components.minute ?? 0 * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hours + minutes),
                                                  estimatedSleep: sleepAmount,
                                                  coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            alertTitle = "Bedtime result time !!!"
            alertMessageText = "You should sleep by \(formatter.string(from: sleepTime)) to meet your goal."
            dismissButtonText = "OK"
        } catch {
            alertTitle = "Error"
            alertMessageText = "Something went wrong- \(error.localizedDescription)"
            dismissButtonText = "Retry"
        }
        showResult.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
