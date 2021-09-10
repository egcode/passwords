//
//  DataManager.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import Foundation

public class DataManager: NSObject {
    
    public static let shared = DataManager()
    private var passwords = [Password]()
    
    override init() {
        super.init()
    }
    
    // MARK: -  Fake Data
    
    public func generateFakeData() {
        for i in 1...5 {
            let password = Password(title: "Title \(i)", password: "Password\(i)", userID: "UserID \(i)", desc: "Description \(i)")
            self.passwords.append(password)
        }
    }
    public func generateFakeDataLong() {
        for i in 1...25 {
            var title = ""
            var pass = ""
            var uid = ""
            var des = ""
            for j in 1...15 {
                title += "Title \(i) \(j)"
                pass += "Password \(i) \(j)"
                uid += "UserID \(i) \(j)"
                des += "Description \(i) \(j)"
            }
            let password = Password(title: title, password: pass, userID: uid, desc: des)
            self.passwords.append(password)
        }
    }

    
    // MARK: - Public
    
    public func getPasswords() -> [Password] {
        return self.passwords
    }
    
    public func addPassword(password:Password) {
        self.passwords.append(password)
    }
    
    
}
