//
//  NetworkManager.swift
//  USAData
//
//  Created by Daniel Silva on 18/10/2024.
//

import Foundation

class NetworkManager {
    
    //MARK: - Properties
    enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum UrlRequestString: String {
        case nationUrl = "https://datausa.io/api/data?drilldowns=Nation&measures=Population"
        case statesUrl = "https://datausa.io/api/data?drilldowns=State&measures=Population&year="
    }
    
    enum NetworkErrors: Error {
        case invalidURL
        case invalidResponse
        case invalidStatusCode(Int)
    }
    
    let urlHeaders: [String: String] = ["Content-Type" : "application/json", "client": "ios"]
    
    
    //MARK: - Request
    public func request<T: Decodable>(stringUrl: String, httpMethod: HttpMethod = .get, parameters: [String:Any]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        let completionBlock: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        var request = URLRequest(url: URL(string:"\(stringUrl)")!)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod.rawValue
        
        
        if (parameters != nil && httpMethod != .get) {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted)
        }
        
        let sessionTask = URLSession(configuration: .default).dataTask(with: request) { (data, response, error) in
            
            guard let urlresponse = response as? HTTPURLResponse else { return completionBlock(.failure(NetworkErrors.invalidResponse))}
            if !(200..<300).contains(urlresponse.statusCode) { return completionBlock(.failure(NetworkErrors.invalidStatusCode(urlresponse.statusCode)))}
            guard let data = data else { return }
            do {
                let infoData = try JSONDecoder().decode(T.self, from: data)
                completionBlock(.success(infoData))
            } catch {
                debugPrint("Error converting: \(error.localizedDescription)")
                completionBlock(.failure(error))
            }
        }
        sessionTask.resume()
    }
}
