//
//  PasswordCreateVC+UITextFieldDelegate.swift
//  Passwords
//
//  Created by Eugene G on 9/9/21.
//

import UIKit

extension PasswordCreateVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.textFieldTitle {
            self.textFieldTitle.resignFirstResponder()
            self.textFieldUserID.becomeFirstResponder()
      } else if textField == self.textFieldUserID {
        self.textFieldUserID.resignFirstResponder()
        self.textFieldPassword.becomeFirstResponder()
      } else if textField == self.textFieldPassword {
        self.textFieldPassword.resignFirstResponder()
        self.textFieldDescription.becomeFirstResponder()
      } else if textField == self.textFieldDescription {
        self.submit()
      }
     return true
    }
  

}
