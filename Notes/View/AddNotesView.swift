//
//  AddNotesVoew.swift
//  Notes
//
//  Created by Dharsini S on 12/09/25.
//

import SwiftUI

struct AddNotesView: View {
    @Binding var title : String
    @Binding var content : String
    @Binding var addNote : Bool
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
                               addNote = false
                               dismiss()
                           }
                       }
                       
                       ToolbarItem(placement: .navigationBarTrailing) {
                           Button("Save") {
                               addNote = false
                               if !title.isEmpty {
                                   notesViewModel.addNote(text: content, title: title)
                               }
                               dismiss()
                           }
                           .bold()
                       }
                   }
        }.presentationDetents([.medium])
    }
}

