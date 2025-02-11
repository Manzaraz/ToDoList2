//
//  ToDo.swift
//  ToDoList2
//
//  Created by Christian Manzaraz on 09/02/2025.
//

import Foundation
import SwiftData

@MainActor
@Model
class ToDo {
    var item: String = ""
    var reminderIsOn = false
    var dueDate = Date.now + 60*60*24
    var notes = ""
    var isCompleted = false
    
    init(item: String = "", reminderIsOn: Bool = false, dueDate: Date = Date.now + 60*60*24, notes: String = "", isCompleted: Bool = false) {
        self.item = item
        self.reminderIsOn = reminderIsOn
        self.dueDate = dueDate
        self.notes = notes
        self.isCompleted = isCompleted
    }
    
}

extension ToDo {
    // MARK: As a "static variable", you can get at preview by referring to the class name, like t8his: "ToDo.preview". You don't need to first creat an objectr form the ToDo class.    
    static var preview: ModelContainer {
        let container = try! ModelContainer(
            for: ToDo.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        
        // Add Mock Data
        container.mainContext.insert(
            ToDo(
                item: "Create SwiftData Lessons",
                reminderIsOn: true,
                dueDate: Date.now + 60*60*24,
                notes: "Now with iOS 6 & Xcode 18",
                isCompleted: false
            )
        )
        container.mainContext.insert(
            ToDo(
                item: "Macedonian Educators Talk",
                reminderIsOn: false,
                dueDate: Date.now + 60*60*44,
                notes: "They want to lear about entrepreneurship",
                isCompleted: false
            )
        )
        container.mainContext.insert(
            ToDo(
                item: "Post Flyers for Swift in Santiago",
                reminderIsOn: true,
                dueDate: Date.now + 60*60*72,
                notes: "To be held at UAH in Chile",
                isCompleted: false
            )
        )
        container.mainContext.insert(
            ToDo(
                item: "Prepare old iPhone for Lily",
                reminderIsOn: false,
                dueDate: Date.now + 60*60*12,
                notes: "She gets my old pro",
                isCompleted: false
            )
        )
        
        return container
    }
}
