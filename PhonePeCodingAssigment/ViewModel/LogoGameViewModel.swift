//
//  LogoGameViewModel.swift
//  PhonePeCodingAssigment
//
//  Created by "" on 26/01/21.
//

import Foundation

class LogoGameViewModel: LogoGameViewModelProtocol {
    
    //MARK: - Properties
    var logoList = LogoList()

    private var logoProxy: LogoProxy {
        return LogoProxy(LogoJsonRepository())
    }
    
    var delegate: LogoGameViewDelegate?
    
    // MARK: - Initialization

    init(attach logoGameView: LogoGameViewDelegate) {
        delegate = logoGameView
    }
    
    func getLogoGameList() {
        let fileName = "logo"
        logoProxy.getLogoList(fileName, successsHandler: { (result) in
            self.logoList = result
            self.delegate?.updateUI(for: .success(result))
        }, failureHandler: { (error) in
            self.delegate?.updateUI(for: .fail(error))
        })
    }
}
