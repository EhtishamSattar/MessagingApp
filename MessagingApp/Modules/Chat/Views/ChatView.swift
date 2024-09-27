import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct ChatView: View {
    @State private var messageText = ""
    @State private var recipientEmail = ""
    @State private var errorMessage = ""
    @State private var chatRecipient: String? // To store the selected recipient
    @State private var showingChatDetail = false // To control navigation

    var body: some View {
        NavigationView {
            VStack {
                // Add a TextField for recipient email
                TextField("Recipient Email", text: $recipientEmail)
                    .padding(12)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                Button(action: checkRecipient) {
                    Text("Check Recipient")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(5)
                }

                // Error message display
                Text(errorMessage)
                    .foregroundColor(.red)

                // Navigation to chat detail
                NavigationLink(destination: ChatDetailView(recipientEmail: chatRecipient ?? ""), isActive: $showingChatDetail) {
                    EmptyView()
                }

                // Message input field
                TextField("Message", text: $messageText)
                    .padding(12)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)

                Button(action: sendMessage) {
                    Text("Send")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(5)
                }
            }
            .padding()
        }
    }

    // Check if recipient exists
    private func checkRecipient() {
        guard !recipientEmail.isEmpty else {
            errorMessage = "Please enter an email address."
            return
        }

        Auth.auth().fetchSignInMethods(forEmail: recipientEmail) { (methods, error) in
            print(methods!)
            if let error = error {
                errorMessage = "Error checking recipient: \(error.localizedDescription)"
                return
            }

            guard let methods = methods, !methods.isEmpty else {
                errorMessage = "Recipient does not exist."
                return
            }

            // Recipient exists, navigate to chat detail
            chatRecipient = recipientEmail
            showingChatDetail = true
            errorMessage = "" // Clear error message
        }
    }

    private func sendMessage() {
        guard let userId = Auth.auth().currentUser?.uid, !messageText.isEmpty, let recipient = chatRecipient else { return }

        let message = Message(senderId: userId, recipientId: recipient, text: messageText)

        do {
            let _ = try Firestore.firestore().collection("messages").addDocument(from: message)
            messageText = "" // Clear the message field
        } catch {
            errorMessage = "Error sending message: \(error.localizedDescription)"
        }
    }
}

#Preview {
    ChatView()
}
