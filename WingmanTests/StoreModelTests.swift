//
//  StoreModelTests.swift
//  WingmanTests
//
//  Created by Kraisorn Soisakhu on 5/17/22.
//

import XCTest
@testable import Wingman

class StoreModelTests: XCTestCase {
    
    func testStoreInfoWithAllInfo() throws {
        let json: [String: Any] = [
          "name": "The Coffee Shop",
          "rating": 4.5,
          "openingTime": "15:01:01.772Z",
          "closingTime": "19:45:51.365Z"
        ]
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            let model = try JSONDecoder().decode(StoreInfo.self, from: data)
            
            XCTAssertEqual(model.name, "The Coffee Shop", "Name must match")
            XCTAssertEqual(model.rating, 4.5, "Rating must match")
            XCTAssertEqual(model.openingTime, "15:01:01.772Z", "Opening time must match")
            XCTAssertEqual(model.closingTime, "19:45:51.365Z", "Closing time must match")
            
        } catch let e {
            print(e.localizedDescription)
        }
    }
    
    func testStoreInfoWithMissmatchType() throws {
        let json: [String: Any] = [
          "name": true,
          "rating": "4.5",
          "openingTime": 2.0,
          "closingTime": 1
        ]
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            let model = try JSONDecoder().decode(StoreInfo.self, from: data)
            
            XCTAssertNil(model.name, "Name missmatch type should be nil")
            XCTAssertEqual(model.rating, 0.0, "Rating missmatch type should be default 0.0")
            XCTAssertNil(model.openingTime, "Opening missmatch type should be nil")
            XCTAssertNil(model.closingTime, "Closing missmatch type should be nil")
            
        } catch let e {
            print(e.localizedDescription)
        }
    }
    
    func testStoreInfoWithMissingSomeInfo() throws {
        let json: [String: Any] = [
          "name": "The Coffee Shop",
          "openingTime": "15:01:01.772Z"
        ]
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            let model = try JSONDecoder().decode(StoreInfo.self, from: data)
            
            XCTAssertEqual(model.name, "The Coffee Shop", "Name must match")
            XCTAssertEqual(model.rating, 0.0, "When no rating key default is 0.0")
            XCTAssertEqual(model.openingTime, "15:01:01.772Z", "Opening time must match")
            XCTAssertNil(model.closingTime, "When missing closing time key the data must be nil")
            
        } catch let e {
            print(e.localizedDescription)
        }
    }
    
    func testProductWithAllInfo() throws {
        let json: [String: Any] = [
            "name": "Latte",
            "price": 50,
            "imageUrl": "https://www.nespresso.com/ncp/res/uploads/recipes/nespresso-recipes-Latte-Art-Tulip.jpg"
        ]
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            let model = try JSONDecoder().decode(Product.self, from: data)
            
            XCTAssertEqual(model.name, "Latte", "Name must match")
            XCTAssertEqual(model.price, 50, "Price must match")
            XCTAssertEqual(model.imageURL?.absoluteString, "https://www.nespresso.com/ncp/res/uploads/recipes/nespresso-recipes-Latte-Art-Tulip.jpg", "Url must match")
            
        } catch let e {
            print(e.localizedDescription)
        }
    }
    
    func testProductWithMissmatchType() throws {
        let json: [String: Any] = [
            "name": true,
            "price": "50",
            "imageUrl": 1
        ]
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            let model = try JSONDecoder().decode(Product.self, from: data)
            
            XCTAssertNil(model.name,"Name missmatch type should be nil")
            XCTAssertEqual(model.price, 0, "Price missmatch should be default 0")
            XCTAssertNil(model.imageURL?.absoluteString,  "Url missmatch type should be nil")
            
        } catch let e {
            print(e.localizedDescription)
        }
    }
    
    func testProductWithMissingSomeInfo() throws {
        let json: [String: Any] = [
            "name": "Latte",
        ]
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            let model = try JSONDecoder().decode(Product.self, from: data)
            
            XCTAssertEqual(model.name, "Latte", "Name must match")
            XCTAssertEqual(model.price, 0, "When missing price key default is 0")
            XCTAssertNil(model.imageURL, "When missing image url key the data must be nil")
            
        } catch let e {
            print(e.localizedDescription)
        }
    }
}
