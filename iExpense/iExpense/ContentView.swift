//
//  ContentView.swift
//  iExpense
//
//  Created by Manas Aggarwal on 24/04/21.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var value: Double
    var type: String
}

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "expenses")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "expenses") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct ContentView: View {
    
    @ObservedObject private var expenses: Expenses = Expenses()
    @State private var isAddExpenseVisible: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) {
                    ListCell(value: $0.value, name: $0.name, type: $0.type)
                }
                .onDelete(perform: deleteExpense)
            }
            .listStyle(GroupedListStyle())
            
            .navigationTitle("iExpense")
            .navigationBarItems(
                trailing:
                    Button(action: { isAddExpenseVisible = true }) {
                        Image(systemName: "plus")
                    }
            )
        }
        .sheet(isPresented: $isAddExpenseVisible) { AddExpenseView(expense: self.expenses) }
    }
    
    func deleteExpense(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ListCell: View {
    
    var value: Double
    var name: String
    var type: String
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading) {
                Text(name)
                    .fontWeight(.bold)
                Text(type)
            }
            Spacer()
            Text("₹\(value, specifier: "%g")")
                .foregroundColor(value > 1000 ? .red : value > 500 ? .yellow : .black)
        }
    }
}

struct AddExpenseView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var expense: Expenses
    
    @State private var expenseName: String = ""
    @State private var expenseValue: String = ""
    @State private var expenseType: String = ""
    
    @State private var isAlertShowing: Bool = false
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Expense Name", text: $expenseName)
                TextField("Expense Value", text: $expenseValue)
                    .keyboardType(.numberPad)
                Picker("Expense type", selection: $expenseType) {
                    ForEach(AddExpenseView.types, id: \.self) {
                        Text($0)
                    }
                }
                
                .navigationBarItems(
                    trailing:
                        Button("Add") {
                            if let actualAmount = Double(expenseValue) {
                                let item = ExpenseItem(name: expenseName,
                                                       value: actualAmount,
                                                       type: expenseType)
                                expense.items.append(item)
                                self.presentationMode.wrappedValue.dismiss()
                            } else {
                                isAlertShowing = true
                            }
                        }
                )
            }
            .alert(isPresented: $isAlertShowing) {
                Alert(title: Text("Error"), message: Text("Please enter a valid expense value"), dismissButton: .default(Text("Okay")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
