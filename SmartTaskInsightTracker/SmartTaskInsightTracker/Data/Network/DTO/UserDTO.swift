//
//  UserDTO.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

struct UserDTO: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: AddressDTO
    let phone: String
    let website: String
    let company: CompanyDTO
}

extension UserDTO {
    func toEntity() -> User {
        User(
            id: id,
            name: name,
            username: username,
            email: email,
            city: address.city,
            companyName: company.name
        )
    }
}
