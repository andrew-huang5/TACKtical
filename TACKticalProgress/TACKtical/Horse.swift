  
//
//  Horse.swift
//  TACKtical
//
//
import Foundation
import SwiftUI

struct Horse: Identifiable & Hashable {
    var id: String
    var arrivalDate: Date
    var height: Int
    var gender: Int
    var birth: Date
    var owner: String
    var feed: Int
    var color: Int
    var name: String
    var ownerName: String
}
  
struct Rider: Identifiable & Hashable {
    var id: String
    var joinedDate: Date
    var height: Int
    var gender: Int
    var age: Int
    var horse: String
    var name: String
    var email: String
    var phone: String
    var horseName: String
}
