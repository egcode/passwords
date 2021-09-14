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
    @objc dynamic var useBiometric = true
    
    let passwords = List<Password>()
    
    convenience init(id:String) {
        self.init()
        self.id = id
    }
        
    public override class func primaryKey() -> String? {
        return "id"
    }
}
