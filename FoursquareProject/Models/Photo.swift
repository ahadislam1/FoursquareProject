//
//  Photo.swift
//  FoursquareProject
//
//  Created by Ahad Islam on 2/25/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import Foundation

// MARK: - PhotoWrapper
struct PhotoWrapper: Codable {
    let meta: Meta
    let response: Response

    enum CodingKeys: String, CodingKey {
        case meta = "meta"
        case response = "response"
    }
}

// MARK: - Meta
struct Meta: Codable {
    let code: Int
    let requestID: String

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case requestID = "requestId"
    }
}

// MARK: - Response
struct Response: Codable {
    let photos: Photos

    enum CodingKeys: String, CodingKey {
        case photos = "photos"
    }
}

// MARK: - Photos
struct Photos: Codable {
    let count: Int
    let items: [Item]
    let dupesRemoved: Int

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case items = "items"
        case dupesRemoved = "dupesRemoved"
    }
}

// MARK: - Item
struct Item: Codable {
    let id: String
    let createdAt: Int
    let source: Source
    let prefix: String
    let suffix: String
    let width: Int
    let height: Int
    let checkin: Checkin
    let visibility: String
    var imageURL: String { prefix + suffix }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "createdAt"
        case source = "source"
        case prefix = "prefix"
        case suffix = "suffix"
        case width = "width"
        case height = "height"
        case checkin = "checkin"
        case visibility = "visibility"
    }
}

extension Item {
   
  func getImageUrl(imageSize: String) -> String {
    self.prefix + "\(imageSize)" + self.suffix
  }
}

// MARK: - Checkin
struct Checkin: Codable {
    let id: String
    let createdAt: Int
    let type: String
    let timeZoneOffset: Int

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "createdAt"
        case type = "type"
        case timeZoneOffset = "timeZoneOffset"
    }
}

// MARK: - Source
struct Source: Codable {
    let name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }
}


