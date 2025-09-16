//
//  CoordinatorView.swift
//  Notes
//
//  Created by Dharsini S on 16/09/25.
//

import SwiftUI

struct RootView: View {
    @StateObject private var coordinator = NotesCoordinator()
    @StateObject private var viewModel = NotesViewModel()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            NotesView(viewModel: viewModel, coordinator: coordinator)
                .navigationDestination(for: NotesScreen.self) { screen in
                    switch screen {
                    case .notes:
                        EmptyView()
                    case .editNote(let note):
                        EditNotesView(notesViewModel: viewModel, note: note).environmentObject(coordinator)
                    }
                }
                .sheet(item: $coordinator.sheet){sheet in
                    switch sheet {
                    case .addNote:
                        AddNotesView(notesViewModel: viewModel).environmentObject(coordinator)
                    }
                }
        }
    }
}
