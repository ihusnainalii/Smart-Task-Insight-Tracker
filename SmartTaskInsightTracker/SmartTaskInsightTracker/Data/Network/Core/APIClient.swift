//
//  APIClient.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import Foundation

final class APIClient {

    private let baseURL: URL
    private let urlSession: URLSession
    private let logger: NetworkLogger

    init(
        baseURL: URL,
        urlSession: URLSession = .shared,
        logger: NetworkLogger
    ) {
        self.baseURL = baseURL
        self.urlSession = urlSession
        self.logger = logger
    }

    func request<T: APIRequest>(
        _ request: T
    ) async throws -> T.Response {
        // Build URL
        guard var urlComponents = URLComponents(
            url: baseURL.appendingPathComponent(request.path.endpoint),
            resolvingAgainstBaseURL: false
        ) else {
            throw APIError.invalidURL
        }
        urlComponents.queryItems = request.queryParameters

        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }

        // Build URLRequest
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        logger.log(request: urlRequest)
        
        do {
            let (data, response) = try await urlSession.data(for: urlRequest)
            
            logger.log(response: response, data: data)

            // Check HTTP status code
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                throw APIError.requestFailed(statusCode: httpResponse.statusCode, data: data)
            }

            return try request.decode(data)

        } catch let error as APIError {
            logger.log(error: error)
            throw error
        } catch {
            logger.log(error: error)
            throw APIError.unknown(error)
        }
    }
}
