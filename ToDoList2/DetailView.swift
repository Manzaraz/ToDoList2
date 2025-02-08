//
//  DetailView.swift
//  ToDoList2
//
//  Created by Christian Manzaraz on 07/02/2025.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Image(systemName: "swift")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.orange)
            
            Text("You Are a Swifty Lengend!")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button("Get Back!") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationBarBackButtonHidden()

    }
}

#Preview {
    DetailView()
}
