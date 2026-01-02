//
//  APIConfig.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import Foundation

struct APIConfig {
    
    // MARK: - Common Headers
    struct Headers {
        static func authorization(with token: String?) -> String? {
            if let token = token {
                return "Bearer \(token)"
            }
            return nil
        }
        static let contentType = "application/json"
        static let accept = "application/json"
    }
    
    // MARK: - Common Query Parameters
    struct Queries {
        static func limit(_ value: Int) -> URLQueryItem {
            URLQueryItem(name: "limit", value: "\(value)")
        }
        
        static func page(_ value: Int) -> URLQueryItem {
            URLQueryItem(name: "page", value: "\(value)")
        }
        
        static func search(_ value: String) -> URLQueryItem {
            URLQueryItem(name: "search", value: value)
        }
        
        static func userId(_ value: String) -> URLQueryItem {
            URLQueryItem(name: "userId", value: value)
        }
        
        static func email(_ value: String) -> URLQueryItem {
            URLQueryItem(name: "email", value: value)
        }
    }
}
