//
//  PasswordsTVC+PasswordsTVCRefreshProtocol.swift
//  Passwords
//
//  Created by Eugene G on 9/14/21.
//

import UIKit

protocol PasswordsTVCRefreshProtocol: AnyObject {
    func addPassword(passwordVM:PasswordViewModel)
    func putToTop(passwordVM: PasswordViewModel)
}

extension PasswordsTVC: PasswordsTVCRefreshProtocol {
    
    func addPassword(passwordVM: PasswordViewModel) {
        self.passwordViewModelParent.addPasswordViewModel(passwordVM: passwordVM)
        self.refreshTableView(animated: false)
    }
    
    func putToTop(passwordVM: PasswordViewModel) {
        if let indPath = passwordVM.originalIndexPath {
            self.passwordViewModelParent.deletePasswordViewModel(index: indPath.row)
            self.passwordViewModelParent.addPasswordViewModel(passwordVM: passwordVM)
            self.refreshTableView(animated: false)
        } else {
            Log.error("⛔️ Error put to top passwordVM")
        }
    }

}
