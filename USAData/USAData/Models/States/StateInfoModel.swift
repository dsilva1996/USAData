//
//  StateInfoModel.swift
//  USAData
//
//  Created by Daniel Silva on 18/10/2024.
//

import Foundation

struct StateInfoModel: Codable {
    let idState: String?
    let state: String?
    let idYear: Int?
    let year: String?
    let population: Int?
    let slugState: String?
    
    enum CodingKeys: String, CodingKey {
        case idState = "ID State"
        case state = "State"
        case idYear = "ID Year"
        case year = "Year"
        case population = "Population"
        case slugState = "Slug State"
    }
}
