// Group 3 - Andrew Huang, Haris Nashed, Maddie Pinard, Zhengkai Xie
// Emails: andrew.huang@vanderbilt.edu, haris.r.nashed@vanderbilt.edu,
//      zhengkai.xie@vanderbilt.edu, madeleine.j.pinard@vanderbilt.edu
// Homework 4

import SwiftUI
import UIKit
import Firebase

@main
struct TACKticalApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
