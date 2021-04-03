//
//  AppState.swift
//  TACKtical
//
//  Created by Madeleine Pinard on 3/30/21.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var user: User?
    var currentUser: User?
}
