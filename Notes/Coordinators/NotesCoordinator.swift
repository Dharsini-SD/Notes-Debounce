//
//  NotesCoordinator.swift
//  Notes
//
//  Created by Dharsini S on 15/09/25.
//

import Foundation
import SwiftUI

class NotesCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var sheet : NotesSheet?

    func showNotes() {
        path.removeLast(path.count) // reset stack
        path.append(NotesScreen.notes)
    }

    func showEdit(note: Note) {
        path.append(NotesScreen.editNote(note))
    }

    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func dismissSheet() {
        sheet = nil
    }
    
    func showSheet(_ sheet: NotesSheet) {
        self.sheet = sheet
    }
}
