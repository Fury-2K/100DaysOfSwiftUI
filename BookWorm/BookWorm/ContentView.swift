//
//  ContentView.swift
//  BookWorm
//
//  Created by Manas Aggarwal on 07/05/21.
//

import SwiftUI
import CoreData

//
//  ContentView.swift
//  BookWorm
//
//  Created by Manas Aggarwal on 05/05/21.
//

import SwiftUI

// --------------------------
// MARK:- @Binding Example
// --------------------------

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool

    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]

    var body: some View {
        Button(title) {
            self.isOn.toggle()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}


//struct ContentView: View {
//    @State private var rememberMe = false
//
//        var body: some View {
//            VStack {
//                PushButton(title: "Remember Me", isOn: $rememberMe)
//                Text(rememberMe ? "On" : "Off")
//            }
//        }
//}

// --------------------------
// MARK:- Size class demo
// --------------------------

//struct ContentView: View {
//    @Environment(\.horizontalSizeClass) var sizeClass
//
//    var body: some View {
//        if sizeClass == .compact {
//            return AnyView(VStack {
//                Text("Active size class:")
//                Text("COMPACT")
//            }
//            .font(.largeTitle))
//        } else {
//            return AnyView(HStack {
//                Text("Active size class:")
//                Text("REGULAR")
//            }
//            .font(.largeTitle))
//        }
//    }
//}

// --------------------------
// MARK:- CoreData Example
// --------------------------

//struct Student {
//    var id: UUID
//    var name: String
//}

/*

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
    
    var body: some View {
        VStack {
            List {
                ForEach(students, id: \.id) { student in
                    Text(student.name ?? "Unknown")
                }
            }
            Button("Add") {
                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                let chosenFirstName = firstNames.randomElement()!
                let chosenLastName = lastNames.randomElement()!

                let student = Student(context: viewContext)
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"
                
                try? viewContext.save()
            }
        }
    }
}
*/

// --------------------------
// MARK:- Main App
// --------------------------

struct ContentView: View {
    
    /// Environment property to store data object
    @Environment(\.managedObjectContext) var moc
    
    /// Unsorted
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
    
    /// Alphabetically sorted
//    @FetchRequest(entity: Book.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Book.title, ascending: true)]) var books: FetchedResults<Book>
    
    /// book title to be sorted ascending first, followed by book author ascending second
//    @FetchRequest(entity: Book.entity(), sortDescriptors: [
//        NSSortDescriptor(keyPath: \Book.title, ascending: true),
//        NSSortDescriptor(keyPath: \Book.author, ascending: true)
//    ]) var books: FetchedResults<Book>

    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(destination: DetailView(book: book)) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown Title")
                                .font(.headline)
                                .foregroundColor(book.rating == 1 ? .red : .black)
                            Text(book.author ?? "Unknown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
                /// Add this to enable move feature in a list
//                .onMove { self.moveFruit(from: $0, to: $1) }
            }
            .navigationBarTitle("Bookworm")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    Button(action: {
                        self.showingAddScreen.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
            )
            .sheet(isPresented: $showingAddScreen) {
                AddBookView().environment(\.managedObjectContext, self.moc)
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our fetch request
            let book = books[offset]

            // delete it from the context
            moc.delete(book)
        }

        // save the context
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
