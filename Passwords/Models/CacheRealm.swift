//
//  CacheRealm.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import Foundation
import RealmSwift


//class CacheRealm: NSObject {
//    
//    fileprivate static var encrypt = false
//    fileprivate static let fileName = "p.realm"
//
//    static let shared: CacheRealm = {
//        return CacheRealm()
//    }()
//}
//
//
//
//extension CacheRealm {
//    
//    fileprivate static func getKey() -> String {
//        if let k = DataManager.shared.keychainReadCacheKey() {
//            return k
//        } else {
//            
//            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
//            var key = ""
//            
//            while key.utf8.count < 64 {
//                let randomLetter = letters.randomElement()
//                key += randomLetter?.description ?? ""
//            }
//            DataManager.shared.keychainSaveCacheKey(key: key)
//            return key
//        }
//    }
//
//    public static func getRealmConfig() -> Realm.Configuration {
//        
//        func getDocsDir() -> NSURL {
//            let fm = FileManager.default
//            return fm.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
//        }
//        
//        guard let dbPath = getDocsDir().appendingPathComponent(fileName) else {
//            print("Unable to get dbPath")
//            return Realm.Configuration()
//        }
//        
//        var schemaVersion: UInt64 = 1
//        let encryptionKey: Data? = encrypt ? CacheRealm.getKey().data(using: String.Encoding.ascii) : nil
//
//        if FileManager.default.fileExists(atPath: dbPath.absoluteString){
//            do {
//                schemaVersion = try schemaVersionAtURL(dbPath, encryptionKey: encryptionKey)
//            } catch let error as NSError {
////            if error.domain == Realm.Error.errorDomain && error.code == Realm.Error.fail.rawValue {
////                Log.debug("Failed to get schema version, Probably file was loaded first time: \n\(error)")
////            } else {
////                Log.error("Schema Version encrypt error: \(error)")
////            }
//                print("Schema Version encrypt error: \(error)")
//            }
//        }
//        
//        let config = Realm.Configuration(fileURL: dbPath, inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: encryptionKey, readOnly: false, schemaVersion: schemaVersion, migrationBlock: self.migrationBlock, deleteRealmIfMigrationNeeded: true, shouldCompactOnLaunch: nil, objectTypes: CacheRealm.modelObjectTypes)
//        return config
//    }
//
//}
//
//
//
//extension CacheRealm {
//    static let modelObjectTypes: [Object.Type] = [
//        CachedRealmUser.self,
//        CachedRealmOrganization.self,
//        CacheRealmDevice.self,
//        CacheRealmThumbnail.self
//    ]
//}
//
//
//extension CacheRealm {
//    static let migrationBlock: RealmSwift.MigrationBlock = { migration, oldSchemaVersion in
//        Log.debug("Realm migration from version \(oldSchemaVersion)")
//        
//        migration.enumerateObjects(ofType: CachedRealmUser.className(), { (oldObject, newObject) in
//            Log.debug("Realm CachedUser old: \(oldObject) to new: \(newObject)")
//            if let old = oldObject, let new = newObject {
////                if new.containsProperty("transId") && new.containsProperty("objectId") == false &&
////                    old.containsProperty("transId") == false && old.containsProperty("objectId") {
////
////                    new["transId"] = old.propertyValue("objectId")
////
////                }
//            }
//        })
//        
//        print("Realm migration complete")
//    }
//}
