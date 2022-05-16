//
//  APIEndPoint.swift
//  Wingman
//
//  Created by Kraisorn Soisakhu on 5/16/22.
//

import Foundation

enum WMAPIEndpoint {
    case storeInfo
    case productList
    case makeOrder
    
    var baseUrl: String {
        return "https://c8d92d0a-6233-4ef7-a229-5a91deb91ea1.mock.pstmn.io"
    }
    
    var path: String {
        switch self {
        case .storeInfo:
            return "\(self.baseUrl)/storeInfo"
        case .productList:
            return "\(self.baseUrl)/products"
        case .makeOrder:
            return "\(self.baseUrl)/order"
        }
    }
}
