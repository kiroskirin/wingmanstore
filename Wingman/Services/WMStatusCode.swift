//
//  WMStatusCode.swift
//  Wingman
//
//  Created by Kraisorn Soisakhu on 5/17/22.
//

import Foundation

enum WMHttpStatusCode: Int {
    // success - 2xx
    case http200_Success = 200
    case http201_Created = 201
    // client error - 4xx
    case http401_Unauthorized = 401
    case http401_Forbidden = 403
    case http404_NotFound = 404
    // server - 5xx
    case http503_ServiceUnavailable = 503
}
