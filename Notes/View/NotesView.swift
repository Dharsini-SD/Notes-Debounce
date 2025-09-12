//
//  NotesView.swift
//  Notes
//
//  Created by Dharsini S on 11/09/25.
//

import SwiftUI
import Combine

struct NotesView: View {
    @StateObject var notesViewModel: NotesViewModel = NotesViewModel()
    @State var addNote : Bool = false
    @State var title : String = ""
    @State var content : String = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            ZStack{
                
                
                VStack{
                   
                    
                    List(notesViewModel.filteredNotes){note in
                        VStack(alignment: .leading){
                            Text(note.title).font(.headline)
                            Text(note.text).font(.caption)
                        }.swipeActions(edge: .trailing) {
                            Button(action: {
                                notesViewModel.deleteNote(of: note.id)
                            }){
                                Image(systemName: "trash.fill")
                            }
                        }
                    }
                }.searchable(text: $notesViewModel.searchText, prompt: "Search")
                
                Image(systemName: "plus.circle.fill").resizable().frame(width: 60, height: 60).foregroundColor(.blue).frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottomTrailing).padding()
                    .onTapGesture {
                        addNote = true
                    }
            }.navigationTitle("Notes")
        }.sheet(isPresented: $addNote){
            NavigationStack{
                Form {
                      Section(header: Text("Title")) {
                          TextField("Enter title", text: $title)
                              .textFieldStyle(.roundedBorder)
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
            }
            
                
        }.presentationDetents([.medium])
       
    }
}

#Preview {
    NotesView()
}
