//
//  PasswordViewModelParent.swift
//  Passwords
//
//  Created by Eugene G on 9/9/21.
//

import UIKit

public class PasswordViewModelParent: NSObject {
    
    public var passwordViewModels = [PasswordViewModel]()
    public var filteredPasswordViewModels = [PasswordViewModel]()
    
    override init() {
        super.init()
        // Getting passwords from cache
        DataManager.shared.cacheGetPasswords { passwords in
            self.passwordViewModels = passwords.map({return PasswordViewModel(password: $0)})
        }
    }
    
    // MARK: - Password management
        
    public func addPasswordViewModel(passwordVM: PasswordViewModel) {
        self.passwordViewModels.append(passwordVM)
    }
    
    public func deletePasswordViewModel(index: Int) {
        self.passwordViewModels.remove(at: index)
    }

    // MARK: - Debug description
    
    override public var debugDescription: String {
        return "\n<\npasswordViewModels.count=\(self.passwordViewModels.count)\npasswordViewModels=\(self.passwordViewModels);\n>"
    }

}
