//
//  TodoDTO.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 02/01/2026.
//


struct TodoDTO: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

extension TodoDTO {
    func toEntity() -> Todo {
        Todo(
            id: id,
            userID: userId,
            title: title,
            isCompleted: completed
        )
    }
}
