//
//  ViewController+UI.swift
//  PhonePeCodingAssigment
//
//  Created by "" on 25/01/21.
//

import Foundation
import UIKit
//MARK: - Configure UI
extension LogoGameViewController {
    
    func updateUI() {
        startTimer()
        configureTextField()
        configureImageView()
        configureHintLabel()
        configureButton()
    }
    
    func configureTextField() {
        logoNameTextField.delegate = self
        logoNameTextField.text = ""
    }
    
    func configureImageView() {
        let logoURl = logoList[activeIndex].imgUrl
        if let logoUrl = URL(string: logoURl) {
            let session = URLSession.init(configuration: URLSessionConfiguration.default)
            session.dataTask(with: logoUrl) { (data, response, error) in
                DispatchQueue.main.sync {
                    if let imageData = data, error == nil {
                        self.logoImgeView.image = UIImage(data: imageData)
                    }
                }
            }.resume()
        }
        
    }
    
    func configureHintLabel() {
        if let activeLogo = self.activeLogo {
            let shuffledNameList = activeLogo.name.shuffled()
            print(shuffledNameList)
            self.hindLabel.text = "Hint: \(String(shuffledNameList))"
        }
    }
    
    func configureButton() {
        nextButton.setTitle("Next", for: .normal)
        puaseButton.setTitle("Pause", for: .normal)
    }
    
}


extension LogoGameViewController: LogoGameViewDelegate {
    func updateUI(for status: Response<LogoList>) {
        switch status {
        case .success(let result):
            self.logoList = result
            self.updateUI()
        case .fail(let error):
            debugPrint(error)
        }
    }
}
