//
//  EditNotesView.swift
//  Notes
//
//  Created by Dharsini S on 12/09/25.
//

import SwiftUI

struct EditNotesView: View {
    @State var title : String
    @State var content : String
    var note : Note
    @ObservedObject var notesViewModel : NotesViewModel
    @Environment(\.dismiss) var dismiss
    
    init(notesViewModel: NotesViewModel,note:Note) {
       
        self.notesViewModel = notesViewModel
        self.note = note
        _title = State(initialValue: note.title)
        _content = State(initialValue: note.text)
    }
    
    var body: some View {
      
            Form {
                Section(header: Text("Title")) {
                    TextField("Enter title", text: $title)
                        //.textFieldStyle(.roundedBorder)
                }
                
                Section(header: Text("Content")) {
                    TextEditor(text: $content)
                        .frame(height: 200)
                }
            }
            .navigationTitle("Edit Note")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            
                            if !title.isEmpty {
                                notesViewModel.editNote(of: note.id, text: content, title: title)
                            }
                            dismiss()
                        }
                        .bold()
                    }
                }
                .presentationDetents([.medium])
     
    }
}

