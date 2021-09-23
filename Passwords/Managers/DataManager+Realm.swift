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
    
    func cacheGetAllUsers() -> [User] {
        return Array(CacheRealm.realm.objects(User.self))
    }
        
    func cacheDeleteUser(user: User) {
        CacheRealm.write {
            CacheRealm.realm.delete(user.passwords)
            CacheRealm.realm.delete(user)
        }
    }

    
    func cacheCreateUser(userName: String, completion: @escaping (User) -> Void) {
        CacheRealm.write {
            let user = User(name: userName)
            CacheRealm.realm.add(user)
            completion(user)
        }
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

    // MARK: - Settings Password
    
    func cacheGetSettingsPassword(completion: @escaping (_ settingsPass: SettingsPassword?) -> Void) {
        guard let usr = self.getUser() else {
            Log.error("⛔️ REALM: Unable get user to get cacheGetSettingsPassword")
            completion(nil)
            return
        }
        completion(usr.settingsPassword)
    }
    
    func cacheSaveSettingsPassword(newPassword: String, yourQuestion: String, yourAnswer: String, completion: @escaping (_ success: Bool) -> Void) {
        guard let usr = self.getUser() else {
            Log.error("⛔️ REALM: Unable get user to get cacheSaveSettingsPassword")
            completion(false)
            return
        }
        CacheRealm.write {
            let newSettingsPass = SettingsPassword(userPassword: newPassword, userSecurityQuestion: yourQuestion, userSecurityAnswer: yourAnswer)
            usr.settingsPassword = newSettingsPass
            completion(true)
        }
    }

    func cacheUpdateSettingsPassword(id: String, newPassword: String, yourQuestion: String, yourAnswer: String, completion: @escaping (_ settingsPass: SettingsPassword?) -> Void) {
        if let sp = CacheRealm.realm.object(ofType: SettingsPassword.self, forPrimaryKey: id) {
            CacheRealm.write {
                sp.userPassword = newPassword
                sp.userSecurityQuestion = yourQuestion
                sp.userSecurityAnswer = yourAnswer
                completion(sp)
            }
        } else {
            completion(nil)
        }
    }

    func cacheDeleteSettingsPassword(completion: @escaping (_ success: Bool) -> Void) {
        guard let usr = self.getUser() else {
            Log.error("⛔️ REALM: Unable get user to get cacheDeleteSettingsPassword")
            completion(false)
            return
        }
        if let sp = usr.settingsPassword {
            CacheRealm.write {
                CacheRealm.realm.delete(sp)
                usr.settingsPassword=nil
                completion(true)
            }
        } else {
            completion(false)
        }
    }

    func cacheUpdateSettingsPasswordUseTouchID(settingPasswordID: String, useTouchFaceID: Bool, completion: @escaping (_ success: Bool) -> Void) {
        if let sp = CacheRealm.realm.object(ofType: SettingsPassword.self, forPrimaryKey: settingPasswordID) {
            CacheRealm.write {
                sp.useTouchFaceID = useTouchFaceID
                completion(true)
            }
        } else {
            completion(false)
        }
    }

    
}
