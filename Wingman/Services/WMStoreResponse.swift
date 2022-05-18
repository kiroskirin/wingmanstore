//
//  StoreResponse.swift
//  Wingman
//
//  Created by Kraisorn Soisakhu on 5/16/22.
//

import Foundation

struct StoreResponse: Codable {
    let data: StoreInfo?
}

struct ProductListResponse: Codable {
    let data: [Product]?
}

struct ServiceResponse: Codable {
    let title: String?
    let message: String?
}

// MARK: Store

struct StoreInfo: Codable {
    let name: String?
    let rating: Double?
    let openingTime: String?
    let closingTime: String?
    
    private enum CodingKeys: String, CodingKey {
        case name, rating
        case openingTime = "openingTime"
        case closingTime = "closingTime"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.name = try values.decode(String.self, forKey: .name)
        } catch {
            self.name = nil
        }
        
        do {
            self.rating = try values.decode(Double.self, forKey: .rating)
        } catch {
            self.rating = 0.0
        }
        
        do {
            self.openingTime = try values.decode(String.self, forKey: .openingTime)
        } catch {
            self.openingTime = nil
        }
        
        do {
            self.closingTime = try values.decode(String.self, forKey: .closingTime)
        } catch {
            self.closingTime = nil
        }
    }
}

// MARK: Product

struct Product: Codable {
    let name: String?
    let price: Int?
    let imageURL: URL?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case price
        case imageURL = "imageUrl"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.name = try values.decode(String.self, forKey: .name)
        } catch {
            self.name = nil
        }
        
        do {
            self.price = try values.decode(Int.self, forKey: .price)
        } catch {
            self.price = 0
        }
        
        do {
            self.imageURL = try values.decode(URL.self, forKey: .imageURL)
        } catch {
            self.imageURL = nil
        }
    }
}

extension Encodable {
    var toDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        
        do {
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        } catch {
            return nil
        }
    }
}
