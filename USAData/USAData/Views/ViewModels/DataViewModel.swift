//
//  DataViewModel.swift
//  USAData
//
//  Created by Daniel Silva on 19/10/2024.
//

import Foundation

class DataViewModel {
    //MARK: - Variables/Constants
    let networkManager = NetworkManager()
    var nationsModel: NationResponseModel?
    var nationsArray: [NationInfoModel] = []
    var statesModel: StatesResponseModel?
    var statesArray: [StateInfoModel] = []
    
    //MARK: - Methods
    func fetchData(completion: @escaping (Bool?, String?) -> Void) {
        self.requestData(completion: completion)
    }
    
    private func setupNationsData(model: NationResponseModel) {
        if let data = model.data, data.count > 0 {
            self.nationsArray = data
        }
    }
    
    private func setupStatesData(model: StatesResponseModel) {
        if let data = model.data, data.count > 0 {
            self.statesArray = data
        }
    }
    
    private func requestData(completion: @escaping (Bool?, String?) -> Void) {
        
        //RQS concurrently
        let group = DispatchGroup()
        var fetchError: String?
        
        //Nations RQS
        group.enter()
        networkManager.getNationInfoRequest { (result: Result<NationResponseModel, Error>) in
            switch result {
            case .success(let model):
                self.nationsModel = model
                self.setupNationsData(model: model)
                group.leave()
            case .failure(let error):
                debugPrint("Response error: \(error.localizedDescription)")
                fetchError = error.localizedDescription
                group.leave()
            }
        }
        
        //States RQS
        group.enter()
        networkManager.getStatesInfoRequest(year: nil) { (result: Result<StatesResponseModel, Error>) in
            switch result {
            case .success(let model):
                self.statesModel = model
                self.setupStatesData(model: model)
                group.leave()
            case .failure(let error):
                debugPrint("Response error: \(error.localizedDescription)")
                fetchError = fetchError != nil ? (fetchError ?? "") + error.localizedDescription : error.localizedDescription
                group.leave()
            }
        }
        
        //RQS end
        group.notify(queue: .main) {
            if let error = fetchError {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
    
    func requestStatesWithYear(year: String, completion: @escaping (Bool?, String?) -> Void) {
        statesArray = []
        networkManager.getStatesInfoRequest(year: year) { (result: Result<StatesResponseModel, Error>) in
            switch result {
            case .success(let model):
                self.statesModel = model
                self.setupStatesData(model: model)
                completion(true,nil)
            case .failure(let error):
                debugPrint("Response error: \(error.localizedDescription)")
                completion(false, error.localizedDescription)
            }
        }
    }
}
