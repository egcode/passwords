//
//  CacheRealm.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import Foundation
import RealmSwift


class CacheRealm: NSObject {
    
    static var realm: Realm {
        get {
            do {
                let config = CacheRealm.getRealmConfig()
                let realm = try Realm(configuration: config)
                return realm
            }
            catch {
                print("⛔️Could not access Realm database:  \(error) \nDeleting...")
                CacheRealm.deleteRealmFileAndLogout()
            }
            return self.realm
        }
    }
    
    public static func write(writeClosure: () -> ()) {
        do {
            try CacheRealm.realm.write {
                writeClosure()
            }
        } catch {
            print("⛔️Could write to Realm database:  \(error) \nDeleting...")
            CacheRealm.deleteRealmFileAndLogout()
        }
    }
    
    fileprivate static var encrypt = false
    fileprivate static let fileName = Constants.CacheNaming.cacheFileName
    
    static let shared: CacheRealm = {
        return CacheRealm()
    }()
}


extension CacheRealm {
    
    fileprivate static func getKey() -> String {
        if let k = DataManager.shared.keychainReadCacheKey() {
            return k
        } else {
            
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            var key = ""
            
            while key.utf8.count < 64 {
                let randomLetter = letters.randomElement()
                key += randomLetter?.description ?? ""
            }
            DataManager.shared.keychainSaveCacheKey(key: key)
            return key
        }
    }

    fileprivate class func getCacheDir() -> NSURL {
//        // Documents
//        let fm = FileManager.default
//        return fm.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        
        // Application Support
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask)

        if let applicationSupportURL = urls.last {
            do {
                try fileManager.createDirectory(at: applicationSupportURL, withIntermediateDirectories: true, attributes: nil)
            } catch let err {
                Log.error(err)
            }
        }
        return urls.first! as NSURL
    }

    fileprivate static func deleteRealmFile() {
        guard let dbPath = CacheRealm.getCacheDir().appendingPathComponent(fileName) else {
            print("⛔️Unable to get Realm path")
            return
        }
        do {
            try FileManager.default.removeItem(at:dbPath)
            print("🔵 Successfully removed Realm file")
        } catch {
            print("🚫🔴Unale to delete Realm file")
        }
    }
    
    public static func deleteRealmFileAndLogout() {
        CacheRealm.deleteRealmFile()
        StartupVC.showLogin(title: "Error", message: "Unable to read cache")
    }
    
    public static func getRealmConfig() -> Realm.Configuration {
                
        guard let dbPath = CacheRealm.getCacheDir().appendingPathComponent(fileName) else {
            print("⛔️Unable to get dbPath")
            return Realm.Configuration()
        }
        
        var schemaVersion: UInt64 = 1
        let encryptionKey: Data? = encrypt ? CacheRealm.getKey().data(using: String.Encoding.ascii) : nil

        if FileManager.default.fileExists(atPath: dbPath.absoluteString){
            do {
                schemaVersion = try schemaVersionAtURL(dbPath, encryptionKey: encryptionKey)
            } catch let error as NSError {
//            if error.domain == Realm.Error.errorDomain && error.code == Realm.Error.fail.rawValue {
//                Log.debug("Failed to get schema version, Probably file was loaded first time: \n\(error)")
//            } else {
//                Log.error("Schema Version encrypt error: \(error)")
//            }
                print("⛔️ Schema Version encrypt error: \(error)")
            }
        }
        
        let config = Realm.Configuration(fileURL: dbPath, inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: encryptionKey, readOnly: false, schemaVersion: schemaVersion, migrationBlock: self.migrationBlock, deleteRealmIfMigrationNeeded: true, shouldCompactOnLaunch: nil, objectTypes: CacheRealm.modelObjectTypes)
        return config
    }

}



extension CacheRealm {
    static let modelObjectTypes: [Object.Type] = [
        User.self,
        Password.self,
        SettingsPassword.self
    ]
}


extension CacheRealm {
    static let migrationBlock: RealmSwift.MigrationBlock = { migration, oldSchemaVersion in
        print("Realm migration from version \(oldSchemaVersion)")
        
        migration.enumerateObjects(ofType: User.className(), { (oldObject, newObject) in
            print("Realm CachedUser old: \(oldObject) to new: \(newObject)")
            if let old = oldObject, let new = newObject {
//                if new.containsProperty("transId") && new.containsProperty("objectId") == false &&
//                    old.containsProperty("transId") == false && old.containsProperty("objectId") {
//
//                    new["transId"] = old.propertyValue("objectId")
//
//                }
            }
        })
        
        print("Realm migration complete")
    }
}

extension CacheRealm {
}
