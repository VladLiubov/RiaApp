//
//  Users.swift
//  RiaApp
//
//  Created by Admin on 06.12.2022.
//

import Foundation

// MARK: - Results
struct Results: Codable, Hashable {
    let results: [UserInfo]
    let info: Info
}

// MARK: - Info
struct Info: Codable, Hashable {
    let seed: String
    let results, page: Int
    let version: String
}

// MARK: - Result
struct UserInfo: Codable, Hashable {
    let name: Name
    let email: String
    let phone: String
    let location: Location
    let picture: Picture
}

// MARK: - ID
struct IDUser: Codable {
    let name: String
}

// MARK: - Location
struct Location: Codable, Hashable {
    let street: Street
    let city: String
    let state: String
    let country: String
    let postcode: Int
    let coordinates: Coordinates
}

// MARK: - Coordinates
struct Coordinates: Codable, Hashable  {
    let latitude: String
    let longitude: String
}

// MARK: - Street
struct Street: Codable, Hashable  {
    let number: Int
    let name: String
}

// MARK: - Name
struct Name: Codable, Hashable {
    let first: String
    let last: String
}

// MARK: - Picture
struct Picture: Codable, Hashable  {
    let large, medium, thumbnail: String
}

