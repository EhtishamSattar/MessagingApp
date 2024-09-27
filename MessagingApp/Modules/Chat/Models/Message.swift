//
//  Message.swift
//  MessagingApp
//
//  Created by Mac on 27/09/2024.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var senderId: String
    var recipientId: String
    var timestamp: Date
    
    init(senderId: String, recipientId: String, text: String, timestamp: Date = Date()) {
        self.id = UUID().uuidString // Automatically generate a unique ID
        self.senderId = senderId
        self.recipientId = recipientId
        self.text = text
        self.timestamp = timestamp
    }
}
