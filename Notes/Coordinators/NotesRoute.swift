//
//  NotesRoute.swift
//  Notes
//
//  Created by Dharsini S on 15/09/25.
//

import Foundation
import SwiftUI

enum NotesScreen: Identifiable, Hashable {
    case notes
    case editNote(Note)

    var id: String {
        switch self {
        case .notes: return "notes"
        case .editNote(let note): return note.id.uuidString
        }
    }
}

enum NotesSheet : Identifiable,Hashable{
    case addNote
    var id: Int {
        switch self {
        case .addNote: return 1
        }
    }
}
