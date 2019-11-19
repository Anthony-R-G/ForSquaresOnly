//
//  FourSquareVenu.swift
//  FourSquare
//
//  Created by Anthony Gonzalez on 11/18/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import Foundation

struct FourSquareVenue: Codable {
    let response: Response
}
struct Response: Codable {
    let venues: [Venues]
}
struct Venues: Codable {
    let id: String
    let name: String
    let location: Location
}
struct Location: Codable {
    let address: String
    let lat: Double
    let lng: Double
    let crossStreet: String?
}

