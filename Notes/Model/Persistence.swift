//
//  Persistence.swift
//  Notes
//
//  Created by Dharsini S on 17/09/25.
//

import Foundation

class LocalStorage {
    
    func save(notes:[Note]){
        UserDefaults.standard.set(nil, forKey: "notes")
        if let notesData = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(notesData, forKey: "notes")
        }
        
    }
    
    func load() -> [Note] {
        if let notesData = UserDefaults.standard.data(forKey: "notes")  {
            do{
                return try JSONDecoder().decode([Note].self, from: notesData)
            }catch {
                return []
            }
            
        }
        return []
    }
}
