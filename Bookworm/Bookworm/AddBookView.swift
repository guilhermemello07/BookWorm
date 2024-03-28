//
//  AddBookView.swift
//  Bookworm
//
//  Created by Guilherme Teixeira de Mello on 3/27/24.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of the book", text: $title)
                    TextField("Author of the book", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) { gen in
                            Text(gen)
                        }
                    }
                }
                
                Section("Write a review of the book") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        modelContext.insert(newBook)
                        dismiss()
                    } label: {
                        Label("Save", systemImage: "square.and.arrow.down")
                    }
                    .disabled(validadeNewBook() == false)
                }
            }
            .navigationTitle("Add a book")
        }
    }
    
    func validadeNewBook() -> Bool {
        if title.isEmpty || author.isEmpty || review.isEmpty {
            return false
        }
        return true
    }
}

#Preview {
    AddBookView()
}
