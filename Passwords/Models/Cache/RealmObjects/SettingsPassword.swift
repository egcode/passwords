//
//  SettingsPassword.swift
//  Passwords
//
//  Created by Eugene G on 9/15/21.
//

import Foundation
import RealmSwift

public class SettingsPassword: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var userPassword = ""
    @objc dynamic var userSecurityQuestion = ""
    @objc dynamic var userSecurityAnswer = ""
    @objc dynamic var useTouchFaceID = false

    convenience init(userPassword: String, userSecurityQuestion: String, userSecurityAnswer: String) {
        self.init()
        self.id = NSUUID().uuidString
        self.userPassword = userPassword
        self.userSecurityQuestion = userSecurityQuestion
        self.userSecurityAnswer = userSecurityAnswer
    }
    
    public override class func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: - Debug description

    public override var debugDescription: String {
        return "\n<\nid=\(self.id) \nuserPassword=\(self.userPassword) \nuserSecurityQuestion=\(self.userSecurityQuestion) \nuserSecurityAnswer=\(self.userSecurityAnswer);\n>"
    }

}
