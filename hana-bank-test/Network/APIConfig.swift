//
//  APIConfig.swift
//  hana-bank-test
//
//  Created by Dion Lamilga on 02/08/25.
//

import Alamofire
import Foundation

protocol APIConfig: URLRequestConvertible {
    var baseURL: String { get }
    var headers: HTTPHeaders { get }
    var methods: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var parameterEncoding: ParameterEncoding { get }
}

extension APIConfig {
    var baseURL: String {
        return "https://api.pokemontcg.io/v2"
    }
    
    var headers: HTTPHeaders {
        HTTPHeaders([
            HTTPHeader(
                name: "X-Api-Key",
                value: "16520be1-6376-4cca-aa01-8ef87babecfc"
            )
        ])
    }
    
    var methods: HTTPMethod {
        return .get
    }

    var parameters: Parameters? {
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
        return Alamofire.URLEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL + path
        let urlRequest = try URLRequest(url: url, method: methods, headers: headers)
        return try parameterEncoding.encode(urlRequest, with: parameters)
    }
}
