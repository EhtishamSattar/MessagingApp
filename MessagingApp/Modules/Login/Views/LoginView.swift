import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var isLoginMode = true
    @State private var loginStatusMessage = ""
    @State private var isLoggedIn = false

    var body: some View {
        NavigationView {
            ScrollView {
                if isLoggedIn {
                    // Navigate directly to ChatView if logged in
                    ChatView()
                } else {
                    VStack(spacing: 16) {
                        Picker(selection: $isLoginMode, label: Text("Login mode")) {
                            Text("Login").tag(true)
                            Text("Sign Up").tag(false)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .padding(12)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(5)

                        ZStack {
                            if isPasswordVisible {
                                TextField("Password", text: $password)
                                    .padding(12)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(5)
                            } else {
                                SecureField("Password", text: $password)
                                    .padding(12)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(5)
                            }

                            HStack {
                                Spacer()
                                Button(action: {
                                    isPasswordVisible.toggle()
                                }) {
                                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.gray)
                                }
                                .padding(.trailing, 16)
                            }
                        }

                        Button(action: handleAction) {
                            HStack {
                                Spacer()
                                Text(isLoginMode ? "Log In" : "Sign Up")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(5)
                                Spacer()
                            }
                        }

                        Text(self.loginStatusMessage)
                            .foregroundColor(.red)
                    }
                    .padding()
                }
            }
            .navigationTitle(isLoginMode ? "Log In" : "Sign Up")
            .onAppear(perform: checkCurrentUser) // Check for current user on appear
        }
    }

    private func handleAction() {
        if isLoginMode {
            loginUser()
        } else {
            createNewAccount()
        }
    }

    private func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.loginStatusMessage = "Failed to login: \(error.localizedDescription)"
                return
            }

            self.loginStatusMessage = "Successfully logged in!"
            isLoggedIn = true
        }
    }

    private func createNewAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.loginStatusMessage = "Failed to create account: \(error.localizedDescription)"
                return
            }

            self.loginStatusMessage = "Successfully created account!"
        }
    }

    private func checkCurrentUser() {
        if Auth.auth().currentUser != nil {
            isLoggedIn = true // User is already logged in
        }
    }
}

#Preview {
    LoginView()
}
