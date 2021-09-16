//
//  DataManager+Realm.swift
//  Passwords
//
//  Created by Eugene G on 9/13/21.
//

import Foundation
import RealmSwift

extension DataManager {
    
    // MARK: - User
        
    func cacheStartUser(userID: String, completion: @escaping (Bool) -> Void) {
//        GCD.cacheThread {
            if let _ =  CacheRealm.realm.object(ofType: User.self, forPrimaryKey: userID) {
                Log.error("🗄 REALM: User with id: \(userID) is already exists")
                completion(true)
            } else {
                CacheRealm.write {
                    let user = User(id: userID)
                    CacheRealm.realm.add(user)
                    completion(true)
                }
            }
//        }
    }
    
    fileprivate func getUser() -> User? {
        return CacheRealm.realm.object(ofType: User.self, forPrimaryKey: DataManager.shared.userID)
    }


    // MARK: - Passwords
    
    func cacheGetPasswords(completion: @escaping ([Password]) -> Void) {
        guard let usr = self.getUser() else {
            Log.error("⛔️REALM: Unable to get User from realm")
            completion([Password]())
            return
        }
//        let sortProperties = [SortDescriptor(keyPath: "title")]
        let sortProperties = [SortDescriptor(keyPath: "updatedAt")]
        let cachedPasswords = usr.passwords.sorted(by: sortProperties)
        completion(Array(cachedPasswords))
    }

    func cacheSavePassword(title: String, password: String, userID: String, desc: String, completion: @escaping (_ password: Password?) -> Void) {
        guard let usr = self.getUser() else {
            Log.error("⛔️REALM: Unable get user to save password to realm")
            completion(nil)
            return
        }
        CacheRealm.write {
            let newPass = Password(title: title, password: password, userID: userID, desc: desc)
            usr.passwords.append(newPass)
            completion(newPass)
        }

    }

    func cacheDeletePassword(id: String, completion: @escaping (_ success: Bool) -> Void) {
        if let passToDel = CacheRealm.realm.objects(Password.self).filter("id = %@", id).first {
            CacheRealm.write {
                CacheRealm.realm.delete(passToDel)
                completion(true)
            }
        } else {
            completion(false)
        }
    }

    func cacheUpdatePassword(id: String, title: String, password: String, userID: String, desc: String, completion: @escaping (_ password: Password?) -> Void) {
        if let pass = CacheRealm.realm.object(ofType: Password.self, forPrimaryKey: id) {
            CacheRealm.write {
                pass.title = title
                pass.password = password
                pass.userID = userID
                pass.desc = desc
                pass.updatedAt = Date()
                completion(pass)
            }
        } else {
            completion(nil)
        }
    }

    // MARK: - Settings
    
    func cacheGetUseTouchFaceID(completion: @escaping (_ isOn: Bool) -> Void) {
        guard let usr = self.getUser() else {
            Log.error("⛔️ REALM: Unable get user to get cacheGetUseBiometric")
            completion(false)
            return
        }
        completion(usr.useTouchFaceID)
    }

    func cacheSetUseTouchFaceID(isOn: Bool, completion: @escaping (_ isOn: Bool) -> Void) {
        guard let usr = self.getUser() else {
            Log.error("⛔️ REALM: Unable get user to get cacheGetUseBiometric")
            completion(false)
            return
        }
        CacheRealm.write {
            usr.useTouchFaceID = isOn
            completion(isOn)
        }
    }


    
    
}
