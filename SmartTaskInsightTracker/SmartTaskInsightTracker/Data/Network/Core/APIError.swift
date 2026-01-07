//
//  APIError.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case requestFailed(statusCode: Int, data: Data?)
    case decodingFailed
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .requestFailed(let statusCode, _):
            return "Request failed with status code \(statusCode)."
        case .decodingFailed:
            return "Failed to decode response."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
