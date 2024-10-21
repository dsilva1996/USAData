//
//  NationInfoModel.swift
//  USAData
//
//  Created by Daniel Silva on 18/10/2024.
//

import Foundation

struct NationInfoModel: Codable {
    let idNation: String?
    let nation: String?
    let idYear: Int?
    let year: String?
    let population: Int?
    let slugNation: String?
    
    enum CodingKeys: String, CodingKey {
        case idNation = "ID Nation"
        case nation = "Nation"
        case idYear = "ID Year"
        case year = "Year"
        case population = "Population"
        case slugNation = "Slug Nation"
    }
}
