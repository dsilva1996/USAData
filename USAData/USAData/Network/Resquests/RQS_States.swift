//
//  RQS_States.swift
//  USAData
//
//  Created by Daniel Silva on 18/10/2024.
//

import Foundation

extension NetworkManager {
    
    //MARK: - Request
    func getStatesInfoRequest(year: String? ,completion: @escaping (Result<StatesResponseModel, Error>) -> Void) {
        request(stringUrl: "\(UrlRequestString.statesUrl.rawValue)\(year ?? "latest")") { (result: Result<StatesResponseModel, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
         }
    }
}
