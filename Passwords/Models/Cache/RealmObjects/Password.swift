//
//  Password.swift
//  Passwords
//
//  Created by Eugene G on 9/13/21.
//

import Foundation
import RealmSwift

public class Password: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var password = ""
    @objc dynamic var userID = ""
    @objc dynamic var desc = ""
    @objc dynamic var updatedAt = Date()

    let user = LinkingObjects(fromType: User.self, property: "passwords")

    convenience init(title: String, password: String, userID: String, desc: String) {
        self.init()
        self.id = NSUUID().uuidString
        self.title = title
        self.password = password
        self.userID = userID
        self.desc = desc
        self.updatedAt = Date()
    }
    
    public override class func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: - Debug description
    
    public override var debugDescription: String {
        return "\n<\nid=\(self.id) title=\(self.title) \npassword=\(self.password) \nuserID=\(self.userID) \ndescription=\(self.desc);\n>"
    }

}
