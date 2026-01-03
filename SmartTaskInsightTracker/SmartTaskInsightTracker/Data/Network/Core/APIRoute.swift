//
//  APIRoute.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

enum APIRoute {
    case users
    case createTodo
    case updateDeleteTodo(Int)
    case todos(Int)
}

extension APIRoute {
    var endpoint: String {
        switch self {
        case .users:
            return "/users"
        case .createTodo:
            return "/todos"
        case .updateDeleteTodo(let todoId):
            return "/todos/\(todoId)"
        case .todos(let userId):
            return "/users/\(userId)/todos"
        }
    }
}
