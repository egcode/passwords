//
//  Password.swift
//  Passwords
//
//  Created by Eugene G on 9/9/21.
//

import Foundation

public class Password: CustomDebugStringConvertible {
    var title = ""
    var password = ""
    var userID = ""
    var desc = ""
    
    init(title: String, password: String, userID: String, desc: String) {
        self.title = title
        self.password = password
        self.userID = userID
        self.desc = desc
    }
    
    // MARK: - Debug description
    
    public var debugDescription: String {
        return "\n<\ntitle=\(self.title) \npassword=\(self.password) \nuserID=\(self.userID) \ndescription=\(self.desc);\n>"
    }

}
