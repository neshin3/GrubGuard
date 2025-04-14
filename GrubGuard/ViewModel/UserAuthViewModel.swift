//
//  UserAuthViewModel.swift
//  GrubGuard
//
//  Created by Nestor on 4/13/25.
//

import Foundation
import FirebaseAuth

class UserAuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isUserSignedIn = false
    @Published var isSignUpMode = false
    @Published var isLoggedOut = false  // Track the logout state

    private var authStateHandle: AuthStateDidChangeListenerHandle?

    init() {
        listenToAuthState()
    }

    private func listenToAuthState() {
        authStateHandle = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self = self else { return }

            if let user = user {
                self.isUserSignedIn = true
                self.isLoggedOut = false  // Not logged out
                print("Signed in user info:")
                print("UID: \(user.uid)")
                print("Email: \(user.email ?? "")")
            } else {
                self.isUserSignedIn = false
                self.isLoggedOut = true  // User is logged out
            }
        }
    }

    func getFriendlyAuthError(_ error: NSError) -> String {
        switch AuthErrorCode(rawValue: error.code) {
        case .emailAlreadyInUse:
            return "Email already in use."
        case .invalidCredential, .wrongPassword:
            return "User not found or Incorrect password."
        case .invalidEmail:
            return "Enter a valid email."
        case .weakPassword:
            return "Password must be at least 6 characters."
        default:
            return error.localizedDescription
        }
    }

    func signIn(completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: self.email, password: self.password) { authResult, error in
            if let error = error as NSError? {
                completion(self.getFriendlyAuthError(error))
            } else {
                completion(nil)
            }
        }
    }

    func signUp(completion: @escaping (String?) -> Void) {
        Auth.auth().createUser(withEmail: self.email, password: self.password) { _, error in
            if let error = error as NSError? {
                completion(self.getFriendlyAuthError(error))
            } else {
                completion(nil)
            }
        }
    }

    func logOut(completion: @escaping (String?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error as NSError {
            completion(error.localizedDescription)
        }
    }

    deinit {
        if let handle = authStateHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
