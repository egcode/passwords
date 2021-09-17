//
//  SettingsCreateEditPasswordVC+UITextFieldDelegate.swift
//  Passwords
//
//  Created by Eugene G on 9/16/21.
//

import UIKit

extension SettingsCreateEditPasswordVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.textFieldNewPassword {
            self.textFieldNewPassword.resignFirstResponder()
            self.textFieldRepeatPassword.becomeFirstResponder()
      } else if textField == self.textFieldRepeatPassword {
            self.textFieldRepeatPassword.resignFirstResponder()
            self.textFieldYourQuestion.becomeFirstResponder()
      } else if textField == self.textFieldYourQuestion {
            self.textFieldYourQuestion.resignFirstResponder()
            self.textFieldYourAnswer.becomeFirstResponder()
      } else if textField == self.textFieldYourAnswer {
            self.submit()
      }
     return true
    }
}
