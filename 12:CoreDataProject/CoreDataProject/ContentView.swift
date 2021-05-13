//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Manas Aggarwal on 12/05/21.
//

import SwiftUI
import CoreData

// --------------------------
// MARK:- \.self example
// --------------------------
/*
struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    
    var body: some View {
        List {
            ForEach([1,2,3,4,5], id: \.self) {
                Text("\($0) is a number")
            }
        }
    }
}
*/

// --------------------------
// MARK:- check before saving
// --------------------------
/*
struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    
    var body: some View {
        Button("Save") {
            if moc.hasChanges {
                try? moc.save()
            }
        }
    }
}
*/

// --------------------------
// MARK:- Wizard thing
// --------------------------
/*
struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }
            
            Button("Add") {
                let wizard = Wizard(context: moc)
                wizard.name = "Harry Potter"
            }
            
            Button("Save") {
                moc.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                do {
                    try moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
*/

// --------------------------
// MARK:- Predicate
// --------------------------

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Star Wars")) var ships: FetchedResults<Ship>

    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
            }

            Button("Add Examples") {
                let ship1 = Ship(context: self.moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"

                let ship2 = Ship(context: self.moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"

                let ship3 = Ship(context: self.moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"

                let ship4 = Ship(context: self.moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"

                try? self.moc.save()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
