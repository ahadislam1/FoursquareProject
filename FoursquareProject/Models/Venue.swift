//
//  Venue.swift
//  FoursquareProject
//
//  Created by Ahad Islam on 2/21/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import Foundation

// MARK: - VenueModel
struct VenueModel: Codable {
    let response: VenueWrapper

    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
}


// MARK: - VenueWrapper
struct VenueWrapper: Codable {
    let venues: [Venue]

    enum CodingKeys: String, CodingKey {
        case venues = "venues"
    }
}

// MARK: - Venue
struct Venue: Codable, Equatable {
    let id: String
    let name: String
    let location: Location
    let categories: [Category]
    let referralID: String
    let hasPerk: Bool
    let venuePage: VenuePage?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case location = "location"
        case categories = "categories"
        case referralID = "referralId"
        case hasPerk = "hasPerk"
        case venuePage = "venuePage"
    }
}

// MARK: - Category
struct Category: Codable, Equatable {
    let id: String
    let name: String
    let pluralName: String
    let shortName: String
    let icon: Icon
    let primary: Bool

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case pluralName = "pluralName"
        case shortName = "shortName"
        case icon = "icon"
        case primary = "primary"
    }
}

// MARK: - Icon
struct Icon: Codable, Equatable {
    let iconPrefix: String
    let suffix: String

    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case suffix = "suffix"
    }
}

// MARK: - Location
struct Location: Codable, Equatable {
    let address: String?
    let crossStreet: String?
    let lat: Double
    let lng: Double
    let labeledLatLngs: [LabeledLatLng]
    let distance: Int
    let postalCode: String?
    let cc: String
    let city: String?
    let state: String
    let country: String
    let formattedAddress: [String]

    enum CodingKeys: String, CodingKey {
        case address = "address"
        case crossStreet = "crossStreet"
        case lat = "lat"
        case lng = "lng"
        case labeledLatLngs = "labeledLatLngs"
        case distance = "distance"
        case postalCode = "postalCode"
        case cc = "cc"
        case city = "city"
        case state = "state"
        case country = "country"
        case formattedAddress = "formattedAddress"
    }
}

// MARK: - LabeledLatLng
struct LabeledLatLng: Codable, Equatable {
    let label: String
    let lat: Double
    let lng: Double

    enum CodingKeys: String, CodingKey {
        case label = "label"
        case lat = "lat"
        case lng = "lng"
    }
}

// MARK: - VenuePage
struct VenuePage: Codable, Equatable {
    let id: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}
