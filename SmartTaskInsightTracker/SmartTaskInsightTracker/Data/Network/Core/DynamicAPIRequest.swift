//
//  DynamicAPIRequest.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//


import Foundation

struct DynamicAPIRequest<Response: Decodable>: APIRequest {
    
    // MARK: - Request properties
    var path: APIRoute
    var method: HTTPMethod
    var queryParameters: [URLQueryItem]? = nil
    var headers: [String: String]? = nil
    var body: Data? = nil
    
    // MARK: - Default headers / query parameters
    private let defaultHeaders: [String: String] = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    
    private let defaultQueryParameters: [URLQueryItem]? = nil
    
    // MARK: - Decoding
    func decode(_ data: Data) throws -> Response {
        try JSONDecoder().decode(Response.self, from: data)
    }
    
    // MARK: - Computed properties to merge defaults with overrides
    var finalHeaders: [String: String] {
        (defaultHeaders.merging(headers ?? [:]) { $1 })
    }
    
    var finalQueryParameters: [URLQueryItem]? {
        if let custom = queryParameters {
            return (defaultQueryParameters ?? []) + custom
        } else {
            return defaultQueryParameters
        }
    }
}
