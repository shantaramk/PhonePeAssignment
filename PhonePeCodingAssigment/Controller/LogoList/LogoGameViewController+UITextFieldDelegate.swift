//
//  ViewController+UITextFieldDelegate.swift
//  PhonePeCodingAssigment
//
//  Created by "" on 25/01/21.
//

import Foundation
import UIKit

//MARK: - TextField Delegate

extension LogoGameViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
          print("TextField did begin editing method called")
      }
      func textFieldDidEndEditing(_ textField: UITextField) {
          print("TextField did end editing method called\(textField.text!)")
        if textField.text != nil {
            if isValidAnswer() {
                gameTimer?.invalidate()
                showNextLogo()
            } else {
                print("try again")
            }
        }
      
      }
      func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
          print("TextField should begin editing method called")
          return true;
      }
      func textFieldShouldClear(_ textField: UITextField) -> Bool {
          print("TextField should clear method called")
          return true;
      }
      func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
          print("TextField should end editing method called")
          return true;
      }
      func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          print("While entering the characters this method gets called")
          return true;
      }
      func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          print("TextField should return method called")
          textField.resignFirstResponder();
          return true;
      }

}
