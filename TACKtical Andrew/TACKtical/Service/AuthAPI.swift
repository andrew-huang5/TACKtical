//
//  AuthAPI.swift
//  TACKtical
//
//  Created by Madeleine Pinard on 3/30/21.
//

import Foundation
import Combine
import FirebaseAuth

protocol AuthAPI {
    func login(email: String, password: String) -> Future<User?, Never>
    func signUp(email: String, password: String) -> Future<User?, Never>
    func loginWithFacebook() -> Future<User?, Never>
}
