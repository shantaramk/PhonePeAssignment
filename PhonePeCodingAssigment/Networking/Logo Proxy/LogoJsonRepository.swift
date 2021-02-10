//
//  LogoRepository.swift
//  PhonePeCodingAssigment
//
//  Created by "" on 25/01/21.
//

import Foundation

class LogoJsonRepository: LogoRequestable {
    
    func getLogoList(_ fileName: String, successsHandler: @escaping (LogoList) -> Void, failureHandler: @escaping (Error?) -> Void) {
        
        if let jsonData = readLocalFile(forName: fileName) {
            do {
                    let decodedData = try JSONDecoder().decode([LogoModel].self,
                                                               from: jsonData)
                    
                successsHandler(decodedData)
                } catch {
                    print("decode error")
                    failureHandler(error)
                }
        }
        
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        guard let bundlePath = Bundle.main.path(forResource: name,
                                                ofType: "txt") else { return nil }
        do {
            if let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}
