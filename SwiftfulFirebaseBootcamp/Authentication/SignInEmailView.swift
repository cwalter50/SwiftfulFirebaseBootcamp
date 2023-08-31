//
//  SignInEmailView.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by Christopher Walter on 8/30/23.
//

import SwiftUI


final class SignInEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signin() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
        print(returnedUserData)
        // Task is no longer needed if we use async. do catch is not longer needed if we add throws.
//        Task {
//            do {
//                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
//                print("success")
//                print(returnedUserData)
//            }catch {
//                print("Error: \(error)")
//            }
//        }

    }
    
}

struct SignInEmailView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        VStack {
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            Button {
                Task {
                    do {
                        try await viewModel.signin()
                        showSignInView = false
                    } catch {
                        print("Error: \(error)")
                    }
                }
            } label: {
                Text("Sign in")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign in with Email")
    }
}

struct SignInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInEmailView(showSignInView: .constant(false))
        }
        
    }
}
