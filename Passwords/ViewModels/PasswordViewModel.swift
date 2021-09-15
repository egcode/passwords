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
    var userID = ""
    var pass = ""
    var desc = ""
    
    public var titleModel = Box("")
    public var userIDModel = Box("")
    public var passModel = Box("")
    public var descModel = Box("")
    
    var originalIndexPath: IndexPath?
    
    init(password:Password) {
        self.updatePassword(password: password)
    }
    
    public func updatePassword(password: Password) {
        self.password = password
        self.title = password.title
        self.userID = password.userID
        self.pass = password.password
        self.desc = password.desc
        
        self.titleModel.value = password.title
        self.userIDModel.value = password.userID
        self.passModel.value = password.password
        self.descModel.value = password.desc
    }
    
    public func getID() -> String {
        return self.password.id
    }
    
    // MARK: - Debug description
    
    public var debugDescription: String {
        return "\n<\ntitle=\(self.password.title) \npassword=\(self.password.password) \nuserID=\(self.password.userID) \ndescription=\(self.password.desc);\n>"
    }

}
