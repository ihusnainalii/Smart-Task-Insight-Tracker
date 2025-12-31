//
//  LoginState.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

enum LoginState: Equatable {
    case idle
    case loading
    case success
    case error(String)
}
