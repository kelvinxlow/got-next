//
//  MockEvent.swift
//  GotNext
//
//  Created by Kelvin Low on 2021-08-26.
//

import Foundation

class MockEvent {
    static let mockEvent = Event(id: UUID(),
                                 name: "Basketball",
                                 date: "Wednesday, September 12, 2021 at 12:00 PM",
                                 timeSince1970: 12345678.0,
                                 location: "Local Playground",
                                 description: "Come on down to the local playground for some pick-up basketball. Looking for anyone trying to play 2v2, 3v3, or 4v4",
                                 numberOfPeople: 20,
                                 sender: "mockemail@gmail.com",
                                 participants: ["mockemail@gmail.com",
                                                "secondmockemail@gmail.com",
                                                "thirdmockemail@gmail.com"],
                                 identifier: UUID().uuidString,
                                 host: "Mock User")
}
