//
//  File.swift
//  PhonePeCodingAssigment
//
//  Created by "" on 26/01/21.
//

import Foundation

class LogoRemoteRepository: LogoRequestable {
    
    //MARK: - Properties
    let apiRequestable: APIRequestable?
    
    //MARK: - Initialization
    
    init(with apiRequestable: APIRequestable) {
        self.apiRequestable = apiRequestable
    }
    
    /// return LogoList
    func getLogoList(_ fileName: String, successsHandler: @escaping (LogoList) -> Void, failureHandler: @escaping (Error?) -> Void) {
        guard let apiRequestable = apiRequestable else {return}
        apiRequestable.performRequest(fileName) { (result) in
            successsHandler(result)
        } failureHandler: { (error) in
            failureHandler(error)
        }

    }
    
}
