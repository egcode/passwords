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
    
    public func generateFakeData() {
        for i in 1...5 {
            let password = Password(title: "Title \(i)", password: "Password\(i)", userID: "UserID \(i)", desc: "Description \(i)")
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
