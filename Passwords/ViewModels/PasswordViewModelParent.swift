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
        self.refreshPasswordViewModels()
    }
    
    // MARK: - Password management
    
    public func refreshPasswordViewModels() {
        self.passwordViewModels = DataManager.shared.getPasswords().map({return PasswordViewModel(password: $0)})
    }
    
    public func addPasswordViewModel(passwordVM: PasswordViewModel) {
        self.passwordViewModels.append(passwordVM)
    }
    
    // MARK: - Debug description
    
    override public var debugDescription: String {
        return "\n<\npasswordViewModels.count=\(self.passwordViewModels.count)\npasswordViewModels=\(self.passwordViewModels);\n>"
    }

}
