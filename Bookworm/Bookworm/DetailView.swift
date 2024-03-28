//
//  DetailView.swift
//  Bookworm
//
//  Created by Guilherme Teixeira de Mello on 3/28/24.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var isShowingAlert = false
    
    let book: Book
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre)
                    .padding(8)
                    .fontWeight(.black)
                    .background(.black)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
                    .offset(x: -8, y: -8)
            }
            
            Text(book.author)
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            
            Text("Read on: \(book.date.formatted(date: .abbreviated, time: .omitted))")
                .font(.subheadline)
            
            Text(book.review)
                .padding()
            
            RatingView(rating: .constant(book.rating))
                .font(.title)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book", isPresented: $isShowingAlert) {
            Button("Delete", role: .destructive) {
                deleteBook()
            }
            Button("Cancel", role: .cancel) {
                
            }
        } message: {
            Text("Are you sure you want to delete this book?")
        }
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                isShowingAlert.toggle()
            }
        }
    }
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "I liked this book a lot", rating: 5)
        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Error creating model container")
    }
}
