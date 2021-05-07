//
//  AddBookView.swift
//  BookWorm
//
//  Created by Manas Aggarwal on 07/05/21.
//

import SwiftUI

struct AddBookView: View {
    
    /// Environment property to store data object
    @Environment(\.managedObjectContext) var moc
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    @State private var isErrorShowing: Bool = false
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                }

                Section {
                    Button("Save") {
                        if genre == "" {
                            isErrorShowing = true
                            return
                        }
                        let newBook = Book(context: self.moc)
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.genre
                        newBook.review = self.review
                        newBook.modifiedDate = Date()

                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add Book")
            .alert(isPresented: $isErrorShowing, content: {
                .init(title: Text("Error!"), message: Text("Genre cannot be empty!"), dismissButton: .default(Text("Okay")))
            })
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
