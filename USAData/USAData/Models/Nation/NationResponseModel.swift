//
//  NationResponseModel.swift
//  USAData
//
//  Created by Daniel Silva on 18/10/2024.
//

import Foundation

struct NationResponseModel: Codable {
    let data: [NationInfoModel]?
    let source: [SourceModel]?
}
