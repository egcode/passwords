//
//  CachedRealmUser.swift
//  Passwords
//
//  Created by Eugene G on 9/13/21.
//

import Foundation
import RealmSwift

public class User: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""

    @objc dynamic var settingsPassword: SettingsPassword?
    
    let passwords = List<Password>()
    
    convenience init(name: String) {
        self.init()
        self.id = NSUUID().uuidString
        self.name = name
    }
        
    public override class func primaryKey() -> String? {
        return "id"
    }
}
