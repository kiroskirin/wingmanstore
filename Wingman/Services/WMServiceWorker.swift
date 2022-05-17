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

enum ConfirmOrderResult {
    case success
    case failure(error: ServiceResponse?)
}

typealias ConfirmOrderCompletionHandler = (ConfirmOrderResult) -> Void

protocol StoreWorkerDelegate: AnyObject {
    func getStore(_ completion: @escaping GetStoreCompletionHandler)
    func getProductList(_ completion: @escaping GetProductListCompletionHandler)
    func confirmOrder(_ products: [[String: Any]], order_address: String, _ completion: @escaping ConfirmOrderCompletionHandler)
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
    
    func confirmOrder(_ products: [[String : Any]], order_address: String, _ completion: @escaping ConfirmOrderCompletionHandler) {
        
        let order: [String: Any] = [
            "products": products,
            "delivery_address": order_address
        ]
        
        AF.request(WMAPIEndpoint.makeOrder.path, method: .post, parameters: order, encoding: JSONEncoding.default).response { response in
            
            guard self.verifyResponse(response.response) else {
                completion(.failure(error: ServiceResponse(title: "Error Title", message: "Error Messagge")))
                return
            }
            
            switch response.result {
            case .success:
                completion(.success)
            case .failure(let error):
                let errorResponse = ServiceResponse(title: "Eror Title", message: error.localizedDescription)
                completion(.failure(error: errorResponse))
            }
        }
    }
}
