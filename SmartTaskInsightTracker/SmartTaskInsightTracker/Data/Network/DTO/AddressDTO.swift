//
//  AddressDTO.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

struct AddressDTO: Decodable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: GeoDTO
}
