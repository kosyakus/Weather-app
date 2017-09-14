//
//  Router.swift
//  HW5_NataliaSinitsyna
//
//  Created by Admin on 29.06.17.
//  Copyright © 2017 GB. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    private var besePath: String {
        return "http://samples.openweathermap.org"
    }
    
    case getWeather(q: String, appId: String)
    
    private var path: String {
        switch self {
        case .getWeather:
            return "/data/2.5/forecast"
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getWeather:
            return .get
        }
    }
    
    private var parameters: Parameters {
        switch self {
        case let .getWeather(q, appId):
            return ["q": q, "appid": appId]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try besePath.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    
    }
}
