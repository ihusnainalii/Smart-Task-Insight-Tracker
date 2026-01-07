//
//  APIRequest.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import Foundation

protocol APIRequest {
    associatedtype Response: Decodable

    var path: APIRoute { get }
    var method: HTTPMethod { get }
    var queryParameters: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
    var body: Data? { get }

    func decode(_ data: Data) throws -> Response
}

extension APIRequest {
    func decode(_ data: Data) throws -> Response {
        try JSONDecoder().decode(Response.self, from: data)
    }
}
