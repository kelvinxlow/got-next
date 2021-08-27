//
//  Event.swift
//  GotNext
//
//  Created by Kelvin Low on 2021-08-24.
//

import Foundation

struct Event: Identifiable {
    var id = UUID()
    
    var name: String
    var date: String
    var timeSince1970: Double
    var location: String
    var description: String
    var numberOfPeople: Int
    var sender: String
    var participants: [String]
    var identifier: String
    var host: String 
}
