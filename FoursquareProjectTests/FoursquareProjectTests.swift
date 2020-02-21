//
//  FoursquareProjectTests.swift
//  FoursquareProjectTests
//
//  Created by Ahad Islam on 2/21/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import XCTest
import DataPersistence
@testable import FoursquareProject

class FoursquareProjectTests: XCTestCase {
    
    func testModel() {
        var venues = [Venue]()
        let endpointURL = "https://api.foursquare.com/v2/venues/search?client_id=\(Secret.clientID)&client_secret=\(Secret.clientSecret)&v=20200221&ll=40.735,-73.78"
        let exp = XCTestExpectation(description: "Testing something.")
        
        GenericCoderAPI.manager.getJSON(objectType: VenueModel.self, with: endpointURL) { result in
            switch result {
            case .failure(let error):
                XCTFail("\(error)")
            case .success(let model):
                venues = model.response.venues
                XCTAssert(venues.isEmpty != true)
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 2)
    }

}
