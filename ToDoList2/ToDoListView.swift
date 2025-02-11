//
//  ToDoListView.swift
//  ToDoList2
//
//  Created by Christian Manzaraz on 07/02/2025.
//

import SwiftUI
import SwiftData

struct ToDoListView: View {
    @Query var toDos: [ToDo]
    /** 🔼 @Query - Fetches data from SwiftData's Model Container, so they can be displayed in SwiftUI Views
        • Query variables will also "trigger View updates" on every change data (similar to how @State works). If you're Swift experienced, SwiftData classes are automatically "Observable" & "Identifiable". You don't add anything else to get this. */

    @State private var sheetIsPresented = false
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(toDos) { toDo in
                    NavigationLink {
                        DetailView(toDo: toDo)
                    } label: {
                        Text(toDo.item)
                    }
                    .font(.title2)
                }
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
            .sheet(isPresented: $sheetIsPresented) {
                NavigationStack {
                    DetailView(toDo: ToDo())
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add New To Do", systemImage: "plus") {
                        sheetIsPresented.toggle()
                    }
                }
            }
        }
    }    
}


#Preview {
    ToDoListView()
        .modelContainer(for: ToDo.self, inMemory: true)
}
