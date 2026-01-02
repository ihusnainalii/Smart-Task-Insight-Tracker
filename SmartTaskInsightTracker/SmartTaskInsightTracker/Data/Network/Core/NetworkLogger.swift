//
//  NetworkLogger.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 03/01/2026.
//

import Foundation

protocol NetworkLogger {
    func log(request: URLRequest)
    func log(response: URLResponse?, data: Data?)
    func log(error: Error)
}

final class ConsoleNetworkLogger: NetworkLogger {

    func log(request: URLRequest) {
        print("""
        🔵 [REQUEST]
        URL: \(request.url?.absoluteString ?? "nil")
        Method: \(request.httpMethod ?? "-")
        Headers: \(request.allHTTPHeaderFields ?? [:])
        Body: \(prettyJSON(from: request.httpBody))
        """)
    }

    func log(response: URLResponse?, data: Data?) {
        guard let httpResponse = response as? HTTPURLResponse else {
            print("🟢 [RESPONSE] No HTTP response")
            return
        }

        print("""
        🟢 [RESPONSE]
        Status: \(httpResponse.statusCode)
        URL: \(httpResponse.url?.absoluteString ?? "nil")
        Body: \(prettyJSON(from: data))
        """)
    }

    func log(error: Error) {
        print("""
        🔴 [ERROR]
        \(error.localizedDescription)
        """)
    }

    // MARK: - Helpers
    private func prettyJSON(from data: Data?) -> String {
        guard
            let data,
            let object = try? JSONSerialization.jsonObject(with: data),
            let prettyData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted),
            let string = String(data: prettyData, encoding: .utf8)
        else {
            return data.flatMap { String(data: $0, encoding: .utf8) } ?? "nil"
        }

        return string
    }
}
