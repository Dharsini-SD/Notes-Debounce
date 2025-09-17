//
//  Notes.swift
//  Notes
//
//  Created by Dharsini S on 11/09/25.
//

import Foundation

struct Note : Identifiable,Hashable,Codable{
    var id : UUID = UUID()
    var title : String = ""
    var text : String = ""
    var lastEditAt : Date = Date()
}
