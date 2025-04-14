//
//  LogOutView.swift
//  GrubGuard
//
//  Created by Nestor on 4/15/25.
//

import SwiftUI

struct LogoutView: View {
    @StateObject private var viewModel = UserAuthViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoggedOut {
                Text("You have successfully logged out.")
                    .foregroundColor(.green)
                    .padding()

                Button("Go to Login") {
                    viewModel.isLoggedOut = false  // Reset the logout flag when navigating back
                }
            } else {
                Button("Log Out") {
                    viewModel.logOut { error in
                        if let error = error {
                            print("Error logging out: \(error)")
                        } else {
                            viewModel.isLoggedOut = true  
                        }
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
            }

            if let errorMessage = viewModel.isLoggedOut ? nil : "Error logging out" {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .navigationTitle("Logout")
    }
}

#Preview {
    LogoutView()
}
