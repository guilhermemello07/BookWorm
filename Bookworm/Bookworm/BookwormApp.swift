//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Guilherme Teixeira de Mello on 3/25/24.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
