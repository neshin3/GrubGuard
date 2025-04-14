//
//  LogoutViewModel.swift
//  GrubGuard
//
//  Created by Nestor on 4/27/25.
//

import Foundation
import FirebaseAuth

class LogoutViewModel: ObservableObject {
    @Published var isLoggingOut: Bool = false
    @Published var isLoggedOut: Bool = false
    @Published var errorMessage: String?

    func logOutUser() {
        self.isLoggingOut = true
        do {
            try Auth.auth().signOut()
            self.isLoggingOut = false
            self.isLoggedOut = true
        } catch {
            self.isLoggingOut = false
            self.errorMessage = "Error logging out: \(error.localizedDescription)"
        }
    }
}
