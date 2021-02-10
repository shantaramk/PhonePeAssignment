//
//  APIManager.swift
//  PhonePeCodingAssigment
//
//  Created by "" on 25/01/21.
//

import Foundation

class LogoProxy {
    
    // MARK: - Properties
    // The Proxy maintains a reference to an object of the LogoRequestable class.
    // It can be either lazy-loaded or passed to the Proxy by the client.
    private var logoRequestable: LogoRequestable?
    
    // MARK: - Initialization
    init(_ logoRequestable: LogoRequestable) {
        self.logoRequestable = logoRequestable
    }
}

//MARK: - Internal Methods

extension LogoProxy {

    func getLogoList(_ path: String,
                     successsHandler: @escaping (LogoList) -> Void,
                     failureHandler: @escaping (Error?) -> Void) {
        if hasAccessControl(path) {
            logoRequestable?.getLogoList(path, successsHandler: { (result) in
                successsHandler(result)
            }, failureHandler: { (error) in
                failureHandler(error)
            })
        }
    }
    
    /// return 'true' When client object has access to a resource
    func hasAccessControl(_ path: String) -> Bool {
         !path.isEmpty
    }
}
