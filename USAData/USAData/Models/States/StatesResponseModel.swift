//
//  StatesResponseModel.swift
//  USAData
//
//  Created by Daniel Silva on 18/10/2024.
//

import Foundation

struct StatesResponseModel: Codable {
    let data: [StateInfoModel]?
    let source: [SourceModel]?
}
