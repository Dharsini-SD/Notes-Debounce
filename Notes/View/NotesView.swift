//
//  NotesView.swift
//  Notes
//
//  Created by Dharsini S on 11/09/25.
//

import SwiftUI
import Combine

struct NotesView: View {
    @ObservedObject var viewModel: NotesViewModel
    @ObservedObject var coordinator: NotesCoordinator
    @State var addNote : Bool = false
    @State var title : String = ""
    @State var content : String = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            ZStack{
                
                
                VStack {
                            List(viewModel.filteredNotes) { note in
                                Button {
                                    coordinator.showEdit(note: note)
                                } label: {
                                    VStack(alignment: .leading) {
                                        Text(note.title).font(.headline)
                                        Text(note.text).font(.subheadline)
                                    }
                                }
                            }

                           
                        }.searchable(text: $viewModel.searchText, prompt: "Search")
                
                Image(systemName: "plus.circle.fill").resizable().frame(width: 60, height: 60).foregroundColor(.blue).frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottomTrailing).padding()
                    .onTapGesture {
                        coordinator.showSheet(.addNote)
                    }
            }.navigationTitle("Notes")
        }
       
    }
}

