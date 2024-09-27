//
//  ChatsDetailsView.swift
//  MessagingApp
//
//  Created by Mac on 27/09/2024.
//

import SwiftUI
import SwiftUI

struct ChatDetailView: View {
    var recipientEmail: String

    @State private var messageText = ""

    var body: some View {
        VStack {
            Text("Chat with \(recipientEmail)")
                .font(.headline)
                .padding()

            // List for displaying messages (you can implement this based on your Message model)
            // Replace this with your messages list and logic
            List {
                // Placeholder for messages
                Text("Message 1")
                Text("Message 2")
            }

            // Message input field
            TextField("Message", text: $messageText)
                .padding(12)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)

            Button(action: {
                // Send message action (you can implement the send logic here)
                // sendMessage(text: messageText)
                messageText = "" // Clear the message field
            }) {
                Text("Send")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(5)
            }
        }
        .navigationTitle("Chat")
        .padding()
    }
}

#Preview {
    ChatDetailView(recipientEmail: "recipient@example.com")
}
