//
//  RQS_Nation.swift
//  USAData
//
//  Created by Daniel Silva on 18/10/2024.
//

import Foundation

extension NetworkManager {
    
    //MARK: - Request
    func getNationInfoRequest(completion: @escaping (Result<NationResponseModel, Error>) -> Void) {
        request(stringUrl: UrlRequestString.nationUrl.rawValue) { (result: Result<NationResponseModel, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
         }
    }
}
