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
                if let configPath = config.fileURL {
                    try FileManager.default.setAttributes([.protectionKey: FileProtectionType.complete], ofItemAtPath: configPath.path)
                    
                    if let protectionLevel = CacheRealm.getFileProtectionLevel(for: configPath) {
                        Log.debug("File protection level: \(protectionLevel)")
                    }

                } else {
                    fatalError("Unable to get path from config")
                }
                return realm
            }
            catch {
                Log.error("⛔️Could not access Realm database:  \(error) \nDeleting...")
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
            Log.error("⛔️Could write to Realm database:  \(error) \nDeleting...")
            CacheRealm.deleteRealmFileAndLogout()
        }
    }
        
    #if DEBUG
    fileprivate static var encrypt = false
    fileprivate static let fileName = Constants.CacheNaming.cacheFileName
    #else
    fileprivate static var encrypt = true
    fileprivate static let fileName = Constants.CacheNaming.cacheFileName
    #endif
    
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
                try fileManager.createDirectory(at: applicationSupportURL, withIntermediateDirectories: true, attributes: [.protectionKey: FileProtectionType.complete])
            } catch let err {
                Log.error(err)
                CacheRealm.deleteRealmFileAndLogout()
            }
        }
        return urls.first! as NSURL
    }

    fileprivate static func deleteRealmFile() {
        guard let dbPath = CacheRealm.getCacheDir().appendingPathComponent(fileName) else {
            Log.error("⛔️Unable to get Realm path")
            return
        }
        do {
            try FileManager.default.removeItem(at:dbPath)
            Log.debug("🔵 Successfully removed Realm file")
        } catch {
            Log.error("🚫🔴Unable to delete Realm file")
        }
    }
    
    public static func deleteRealmFileAndLogout() {
        CacheRealm.deleteRealmFile()
        StartupVC.showLogin(title: "Error", message: "Unable to read cache")
    }
    
    public static func getRealmConfig() -> Realm.Configuration {
                
        guard let dbPath = CacheRealm.getCacheDir().appendingPathComponent(fileName) else {
            Log.error("⛔️Unable to get dbPath")
            return Realm.Configuration()
        }
        
        var schemaVersion: UInt64 = 1
        let encryptionKey: Data? = encrypt ? CacheRealm.getKey().data(using: String.Encoding.ascii) : nil

        if encrypt,
        let key = encryptionKey,
           key.count != 64 {
            Log.error("⛔️ encryption key length is \(key.count), should be 64")
            DataManager.shared.keychainRemoveCacheKey()
            CacheRealm.deleteRealmFileAndLogout()
            exit(0)
            return Realm.Configuration()
        }
        
        if FileManager.default.fileExists(atPath: dbPath.absoluteString){
            do {
                schemaVersion = try schemaVersionAtURL(dbPath, encryptionKey: encryptionKey)
            } catch let error as NSError {
//            if error.domain == Realm.Error.errorDomain && error.code == Realm.Error.fail.rawValue {
//                Log.debug("Failed to get schema version, Probably file was loaded first time: \n\(error)")
//            } else {
//                Log.error("Schema Version encrypt error: \(error)")
//            }
                Log.error("⛔️ Schema Version encrypt error: \(error)")
                CacheRealm.deleteRealmFileAndLogout()
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
        Log.debug("Realm migration from version \(oldSchemaVersion)")
        
        migration.enumerateObjects(ofType: User.className(), { (oldObject, newObject) in
            Log.debug("Realm CachedUser old: \(oldObject) to new: \(newObject)")
            if let old = oldObject, let new = newObject {
//                if new.containsProperty("transId") && new.containsProperty("objectId") == false &&
//                    old.containsProperty("transId") == false && old.containsProperty("objectId") {
//
//                    new["transId"] = old.propertyValue("objectId")
//
//                }
            }
        })
        
        Log.debug("Realm migration complete")
    }
}

extension CacheRealm {
    
    public static func getFileProtectionLevel(for fileURL: URL) -> URLFileProtection? {
        let fileManager = FileManager.default
        let resourceKey = URLResourceKey.fileProtectionKey
        do {
            let resourceValues = try fileURL.resourceValues(forKeys: Set([resourceKey]))
            if let protectionLevel = resourceValues.fileProtection {
                return protectionLevel
            } else {
                Log.error("File protection level not found")
                return nil
            }
        } catch {
            Log.error("Error retrieving file protection level: \(error)")
            return nil
        }
    }
}
