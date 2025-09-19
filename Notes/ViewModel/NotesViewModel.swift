//
//  NotesViewModel.swift
//  Notes
//
//  Created by Dharsini S on 11/09/25.
//

import Foundation
import Combine


class NotesViewModel : ObservableObject{
    @Published var notes: [Note] = []
    @Published var searchText: String = ""
    @Published var filteredNotes: [Note] = []
    @Published var cancellable : Set<AnyCancellable> = []
    private var localStorage = LocalStorage()
    init() {
        self.notes =  [
            Note(title: "Grocery List",
                 text: "Buy milk, eggs, bread, and vegetables",
                 lastEditAt: Date()),

            Note(title: "Workout Plan",
                 text: "Pushups, squats, running, and yoga",
                 lastEditAt: Calendar.current.date(byAdding: .day, value: -1, to: Date())!),

            Note(title: "iOS Learning",
                 text: "Practice SwiftUI, Combine, and Core Data daily",
                 lastEditAt: Calendar.current.date(byAdding: .day, value: -2, to: Date())!),

            Note(title: "Meeting Notes",
                 text: "Discuss roadmap, deadlines, and responsibilities",
                 lastEditAt: Calendar.current.date(byAdding: .hour, value: -5, to: Date())!),

            Note(title: "Travel Plan",
                 text: "Book tickets and hotel for Kerala trip",
                 lastEditAt: Calendar.current.date(byAdding: .day, value: -7, to: Date())!)
        ]
        
        $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [weak self] searchItem in
                
                self?.filterNotes(searchText: searchItem)
                
                  
            }
            .store(in: &cancellable)
        
        localStorage.save(notes: notes)
        notes = localStorage.load()
            
        }
    

    func filterNotes(searchText : String){
        if searchText.isEmpty{
            filteredNotes = notes
        }else{
            filteredNotes = notes.filter{
                $0.title.lowercased().contains(searchText.lowercased()) || $0.text.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func sortWithDate(){
        notes.sort { $0.lastEditAt > $1.lastEditAt  }
    }
    
    
    func addNote(text: String,title: String){
        notes.append(Note(id: UUID(), title: title, text: text,lastEditAt: Date.now))
        filteredNotes = notes
        localStorage.save(notes: notes)
    }
    func deleteNote(of id:UUID){
        notes.count > 1 ? notes.removeAll(where: { $0.id == id }) : print("Cannot delete last note")
        filteredNotes = notes
        localStorage.save(notes: notes)
    }
    
    func editNote(of id:UUID,text:String,title:String){
        if notes.count > 0{
            if let index = notes.firstIndex(where: { $0.id == id }) {
                notes[index].title = title
                notes[index].text = text
                notes[index].lastEditAt = Date()
            }
        }
        filteredNotes = notes
        localStorage.save(notes: notes)
    }
    
}
