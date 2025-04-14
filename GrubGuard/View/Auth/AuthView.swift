//
//  AuthView.swift
//  GrubGuard
//
//  Created by Nestor on 4/13/25.
//

import SwiftUI
import FirebaseAuth

struct AuthView: View {
    @ObservedObject var viewModel: UserAuthViewModel
    @State private var errorMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $viewModel.email)
                .autocapitalization(.none)
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            Button(viewModel.isSignUpMode ? "Sign Up" : "Sign In") {
                if viewModel.isSignUpMode {
                    viewModel.signUp { error in
                        if let error = error {
                            errorMessage = error
                        }
                    }
                } else {
                    viewModel.signIn { error in
                        if let error = error {
                            errorMessage = error
                        }
                    }
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)

            Toggle(viewModel.isSignUpMode ? "Switch to Sign In" : "Switch to Sign Up", isOn: $viewModel.isSignUpMode)
                .onChange(of: viewModel.isSignUpMode) {
                    errorMessage = ""
                }
                .padding(.top)
        }
        .padding()
        .navigationTitle(viewModel.isSignUpMode ? "Sign Up" : "Sign In")
    }
}

#Preview {
    AuthView(viewModel: UserAuthViewModel())
}
