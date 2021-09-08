//
//  DataManager+Keychain.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import Foundation

// MARK: - Keychain

extension DataManager {
    
    fileprivate static let keychainStoreCache = KeychainStore(secureStoreQueryable: GenericPasswordQueryable(service: "StoreCache"))
}




// MARK: Cache password

extension DataManager {
    
    public func keychainSaveCacheKey(key:String) {
        do {
            try DataManager.keychainStoreCache.setValue(key, for: Constants.KeychainKey.cacheKey)
        } catch (let e) {
            print("Saving Cache key failed with \(e.localizedDescription).")
        }
    }
    
    public func keychainReadCacheKey() -> String? {
        do {
            let key = try DataManager.keychainStoreCache.getValue(for: Constants.KeychainKey.cacheKey)
            return key
        } catch (let e) {
            print("Reading Cache key failed with \(e.localizedDescription).")
            return nil
        }
    }
    
    public func keychainRemoveCacheKey() {
        do {
            try DataManager.keychainStoreCache.removeAllValues()
        } catch (let e) {
            print("Remove Cache key failed with \(e.localizedDescription).")
        }
    }

}
