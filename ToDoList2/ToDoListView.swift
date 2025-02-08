//
//  ToDoListView.swift
//  ToDoList2
//
//  Created by Christian Manzaraz on 07/02/2025.
//

import SwiftUI

struct ToDoListView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    DetailView()
                } label: {
                    Image(systemName: "eye")
                    Text("Show the New View!")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            
        }
    }
}

#Preview {
    ToDoListView()
}
