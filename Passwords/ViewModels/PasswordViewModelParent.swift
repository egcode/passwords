//
//  PasswordViewModelParent.swift
//  Passwords
//
//  Created by Eugene G on 9/9/21.
//

import UIKit

public class PasswordViewModelParent: NSObject {
    
    public var passwordViewModels = [PasswordViewModel]()
    
    override init() {
        self.passwordViewModels = DataManager.shared.passwords.map({return PasswordViewModel(password: $0)})
    }
    
    // MARK: - Debug description
    
    override public var debugDescription: String {
        return "\n<\npasswordViewModels.count=\(self.passwordViewModels.count)\npasswordViewModels=\(self.passwordViewModels);\n>"
    }

}
