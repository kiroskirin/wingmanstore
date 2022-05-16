//
//  WMServiceWorker.swift
//  Wingman
//
//  Created by Kraisorn Soisakhu on 5/16/22.
//

import Foundation
import Alamofire

enum GetStoreResult {
    case success(result: StoreResponse?)
    case failure(error: ServiceResponse?)
}

typealias GetStoreCompletionHandler = (GetStoreResult) -> Void

enum GetProductListResult {
    case success(result: ProductListResponse?)
    case failure(error: ServiceResponse?)
}

typealias GetProductListCompletionHandler = (GetProductListResult) -> Void

protocol StoreWorkerDelegate: AnyObject {
    func getStore(_ completion: @escaping GetStoreCompletionHandler)
    func getProductList(_ completion: @escaping GetProductListCompletionHandler)
}

/// WM Service Worker

class WMServiceWorker {
    init() {}
}

extension WMServiceWorker: StoreWorkerDelegate {
    var headers: HTTPHeaders {
        return [
            .accept("application/json")
        ]
    }
    
    func verifyResponse(_ httpUrlResponse: HTTPURLResponse?) -> Bool {
        guard let statusCode = httpUrlResponse?.statusCode, let code = WMHttpStatusCode(rawValue: statusCode) else {
            // If code not in list
            // just let it go
            return true
        }
        
        return code == .http200_Success || code == .http201_Created
    }
    
    func getStore(_ completion: @escaping GetStoreCompletionHandler) {
        
        AF.request(WMAPIEndpoint.storeInfo.path, headers: self.headers)
            .responseDecodable(of: StoreInfo.self) { response in
            
            guard self.verifyResponse(response.response) else {
                completion(.failure(error: ServiceResponse(title: "Error Title", message: "Error Messagge")))
                return
            }
            
            switch response.result {
            case .success(let data):
                let storeResponse = StoreResponse(data: data)
                completion(.success(result: storeResponse))
            case .failure(let error):
                let errorResponse = ServiceResponse(title: "Eror Title", message: error.localizedDescription)
                completion(.failure(error: errorResponse))
            }
        }
    }
    
    func getProductList(_ completion: @escaping GetProductListCompletionHandler) {
        
        AF.request(WMAPIEndpoint.productList.path, headers: self.headers)
            .responseDecodable(of: [Product].self) { response in
            
            guard self.verifyResponse(response.response) else {
                completion(.failure(error: ServiceResponse(title: "Error Title", message: "Error Messagge")))
                return
            }
            
            switch response.result {
            case .success(let data):
                let storeResponse = ProductListResponse(data: data)
                completion(.success(result: storeResponse))
            case .failure(let error):
                let errorResponse = ServiceResponse(title: "Eror Title", message: error.localizedDescription)
                completion(.failure(error: errorResponse))
            }
        }
    }
}
