//
//  FourSquareVenue.swift
//  FourSquare
//
//  Created by Anthony Gonzalez on 11/19/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import Foundation

struct FourSquareVenues: Codable {
    let response: ResponseWrapper
}
struct ResponseWrapper: Codable {
    let venues: [Venue]
}
struct Venue: Codable {
    let id: String
    let name: String
    let location: Location
}
struct Location: Codable {
    let address: String?
    let lat: Double
    let lng: Double
    let crossStreet: String?
}
