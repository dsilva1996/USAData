//
//  SourceModel.swift
//  USAData
//
//  Created by Daniel Silva on 18/10/2024.
//

import Foundation

struct SourceModel: Codable {
    let measures: [String]?
    let annotations: SourceAnnotations?
    let name: String?
}

struct SourceAnnotations: Codable {
    let sourceName: String?
    let sourceDescription: String?
    let datasetName: String?
    let datasetLink: String?
    let tableID: String?
    let topic: String?
    let subtopic: String?

    enum CodingKeys: String, CodingKey {
        case sourceName = "source_name"
        case sourceDescription = "source_description"
        case datasetName = "dataset_name"
        case datasetLink = "dataset_link"
        case tableID = "table_id"
        case topic
        case subtopic
    }
}
