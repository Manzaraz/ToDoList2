//
//  ToDoListView.swift
//  ToDoList2
//
//  Created by Christian Manzaraz on 07/02/2025.
//

import SwiftUI
import SwiftData

enum SortOption: String, CaseIterable {
   case asEntered = "As Entered"
   case alphabetical = "A-Z"
   case chronological = "Date"
   case completed = "Not Done"
}

struct SortedToDoList: View {
    @Query var toDos: [ToDo] /** 🔼 @Query - Fetches data from SwiftData's Model Container, so they can be displayed in SwiftUI Views
    • Query variables will also "trigger View updates" on every change data (similar to how @State works). If you're Swift experienced, SwiftData classes are automatically "Observable" & "Identifiable". You don't add anything else to get this. */
    
    @Environment(\.modelContext) var modelContext
    
    let sortSelection: SortOption
    
    init(sortSelection: SortOption) {
        self.sortSelection = sortSelection
        
        switch self.sortSelection {
        case .asEntered:
            _toDos = Query()
        case .alphabetical:
            _toDos = Query(
                sort: \.item)
        case .chronological:
            _toDos = Query(
                sort: \.dueDate)
        case .completed:
            _toDos = Query(
                filter: #Predicate { $0.isCompleted == false })
        }
    }

    var body: some View {
        List {
            ForEach(toDos) { toDo in
                VStack (alignment: .leading) {
                    HStack {
                        Image(systemName: toDo.isCompleted ? "checkmark.rectangle.portrait.fill" : "rectangle.portrait")
                            .foregroundStyle(Color.accentColor)
                            .onTapGesture {
                                toDo.isCompleted.toggle()
                                guard let _ = try? modelContext.save() else {
                                    print("😡 ERROR: Save after .toggle on ToDoListView did not work.")
                                    return
                                }
                            }
                        
                        NavigationLink {
                            DetailView(toDo: toDo)
                        } label: {
                            Text(toDo.item)
                        }
                        .font(.title2)
                    }
                    .swipeActions { /* .swipeActions Technicque: used INSIDE a ForEach clause*/
                        Button(role: .destructive) {
                            modelContext.delete(toDo)
                            
                            guard let _ = try? modelContext.save() else {
                                print("😡 ERROR: Save after .delete on ToDoListView did not work!")
                                return
                            }
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
                    
                    HStack {
                        Text(toDo.dueDate.formatted(date: .abbreviated, time: .shortened))
                            .foregroundStyle(.secondary)
                        
                        if toDo.reminderIsOn  {
                            Image(systemName: "calendar.badge.clock")
                                .symbolRenderingMode(.multicolor)
                        }
                    }
                }
            }
            //                .onDelete { indexSet in
            //                    indexSet.forEach { modelContext.delete(toDos[$0]) }
            //
            //                    guard let _ = try? modelContext.save() else {
            //                        print("😡 ERROR: Save after .delete did not work!")
            //                        return
            //                    }
            //                } /* .onDelete Technique: Use OUTSIDE a ForEach clause*/
        }
        .listStyle(.plain)
    }
}

struct ToDoListView: View {
    
    @State private var sheetIsPresented = false
    @State private var sortSelection: SortOption = .asEntered
    
    
    var body: some View {
        NavigationStack {
            SortedToDoList(sortSelection: sortSelection)
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
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
                
                ToolbarItem(placement: .bottomBar) {
                    Picker("", selection: $sortSelection) {
                        ForEach(SortOption.allCases, id: \.self) { sortOrder in
                            Text(sortOrder.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
    }
}


#Preview {
    ToDoListView()
        .modelContainer(ToDo.preview)
}
