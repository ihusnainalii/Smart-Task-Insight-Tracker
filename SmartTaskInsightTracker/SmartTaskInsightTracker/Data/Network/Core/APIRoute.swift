//
//  APIRoute.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

enum APIRoute {
    case users
    case todos
}

extension APIRoute {
    var endpoint: String {
        switch self {
        case .users:
            return "/users"
        case .todos:
            return "/todos"
        }
    }
}
