//
//  PasswordViewModel.swift
//  Passwords
//
//  Created by Eugene G on 9/9/21.
//

import UIKit

public class PasswordViewModel: CustomDebugStringConvertible {
    private var password: Password!
    
    var title = ""
    var desc = ""
    
    init(password:Password) {
        self.title = password.title
        self.desc = password.desc
    }
    
    // MARK: - Debug description
    
    public var debugDescription: String {
        return "\n<\ntitle=\(self.password.title) \npassword=\(self.password.password) \nuserID=\(self.password.userID) \ndescription=\(self.password.desc);\n>"
    }

}
