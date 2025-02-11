//
//  ToDoList2App.swift
//  ToDoList2
//
//  Created by Christian Manzaraz on 07/02/2025.
//

import SwiftUI
import SwiftData

@main
struct ToDoList2App: App {
    var body: some Scene {
        WindowGroup {
            ToDoListView()
                .modelContainer(for: ToDo.self)
        }
    }
    
    // Will allow us to find where our simulator data is saved:
    init() {
        print(
            URL.applicationSupportDirectory.path(
                percentEncoded: false
            )
        )
    }
}
