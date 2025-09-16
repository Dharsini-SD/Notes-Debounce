//
//  AddNotesVoew.swift
//  Notes
//
//  Created by Dharsini S on 12/09/25.
//

import SwiftUI

struct AddNotesView: View {
    @State var title : String = ""
    @State var content : String = ""
    @EnvironmentObject var coordinator : NotesCoordinator
    @ObservedObject var notesViewModel : NotesViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            Form {
                  Section(header: Text("Title")) {
                      TextField("Enter title", text: $title)
                         // .textFieldStyle(.roundedBorder)
                  }
                  
                  Section(header: Text("Content")) {
                      TextEditor(text: $content)
                          .frame(height: 200)
                  }
              }.navigationTitle("Add Note")
                .toolbar {
                       ToolbarItem(placement: .navigationBarLeading) {
                           Button("Cancel") {
                               
                               coordinator.dismissSheet()
                           }
                       }
                       
                       ToolbarItem(placement: .navigationBarTrailing) {
                           Button("Save") {
                               
                               if !title.isEmpty {
                                   notesViewModel.addNote(text: content, title: title)
                               }
                               coordinator.dismissSheet()
                           }
                           .bold()
                       }
                   }
        }.presentationDetents([.medium])
    }
}

