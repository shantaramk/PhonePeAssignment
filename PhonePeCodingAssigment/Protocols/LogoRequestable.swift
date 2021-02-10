//
//  Protocols.swift
//  PhonePeCodingAssigment
//
//  Created by "" on 25/01/21.
//

import Foundation

enum Response<T: Decodable> {
    case success(_ result: T)
    case fail(_ error: Error?)
}
/// LogoRequestable Protocol
protocol LogoRequestable {
    
    ///return LogoList if valid input path provides
     func getLogoList(_ fileName: String,
                     successsHandler: @escaping(LogoList) -> Void,
                     failureHandler: @escaping(Error?) -> Void)

}

/// LogoGameView Protocol
protocol LogoGameViewDelegate {
    func updateUI(for status: Response<LogoList>)
}

/// LogoGameView Protocol
protocol LogoGameViewModelProtocol {
    func getLogoGameList()
}
