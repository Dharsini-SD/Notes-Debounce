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
                        NavigationLink(destination: EditNotesView(notesViewModel: notesViewModel, note: note)){
                            VStack(alignment: .leading){
                               HStack{
                                   Text(note.title).font(.headline)
                                   Spacer()
                                   Text(note.lastEditAt.formatted()).font(.subheadline)
                               }
                               
                               Text(note.text).font(.caption)
                           }.swipeActions(edge: .trailing) {
                               Button(action: {
                                   notesViewModel.deleteNote(of: note.id)
                               }){
                                   Image(systemName: "trash.fill")
                               }
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
            
            AddNotesView(title: $title, content: $content, addNote: $addNote, notesViewModel: notesViewModel)
                
        }
       
    }
}

#Preview {
    NotesView()
}
