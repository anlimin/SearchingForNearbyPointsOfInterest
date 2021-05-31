//
//  Place.swift
//  MapSearch
//
//  Created by Map04 on 2021-05-20.
//  Copyright © 2021 Apple. All rights reserved.
//


import Foundation
extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap{ URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
struct Place: Codable {
    let id: String
    let name: String
    let price: String?
    let distance: Double
    let imageUrl: String?
    let categories: [Categories]
    let coordinates: Coordinates
    let url: String
    let phone: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case distance
        case imageUrl = "image_url"
        case categories
        case coordinates
        case url
        case phone
    }
}

struct Categories: Codable {
    let alias: String
    let title: String
}

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
}

