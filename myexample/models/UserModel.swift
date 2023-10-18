//
//  UserModel.swift
//  myexample
//
//  Created by Luis Humberto Carlin Vargas on 18/10/23.
//

import Foundation

struct UserData: Codable {
    let results: [User]
}

struct User: Codable {
    let name: Name
    let location: Location
}

struct Name: Codable {
    let first: String
    let last: String
}

struct Location: Codable {
    let coordinates: Coordinates
}

struct Coordinates: Codable {
    let latitude: String
    let longitude: String
}
