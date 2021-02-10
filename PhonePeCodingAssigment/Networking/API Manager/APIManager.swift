//
//  APIManager.swift
//  PhonePeCodingAssigment
//
//  Created by "" on 26/01/21.
//

import UIKit
protocol APIRequestable {
    
    func performRequest<T: Decodable>(_ path: String,
                        successHandler: @escaping(T) -> Void,
                        failureHandler: @escaping(Error?) -> Void)
}

class APIManager: APIRequestable {
    func performRequest<T>(_ path: String,
                           successHandler: @escaping (T) -> Void,
                           failureHandler: @escaping (Error?) -> Void) where T : Decodable {
        
        let sessionConfigure = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfigure)
        let urlRequest = URLRequest(url: URL(string: path)!)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let jsonModel = try JSONDecoder().decode(T.self, from: data)
                        successHandler(jsonModel)
                    } catch let error {
                        failureHandler(error)
                    }
                } else {
                    failureHandler(nil)
                }
            }
        }.resume()
         
    }
}
