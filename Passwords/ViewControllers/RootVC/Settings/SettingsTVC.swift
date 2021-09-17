//
//  SettingsTVC.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import UIKit


class SettingsTVC: BaseTVC {
    
    enum CellType {
        case none
        case touchFaceID
        case passwordEnable
        case passwordChange
        case exportPassword
    }
    struct Cell {
        var title: String
        var type: CellType
        var action: (() -> (Void))?
    }
    struct Segment {
        var title: String
        var cells = [Cell]()
    }
    var sect = [Segment]()
    
    // MARK: - init/deinit
    
    @objc public static func initFromStoryboard() -> SettingsTVC {
        let sb = UIStoryboard(name: "RootVC", bundle: Bundle(for: SettingsTVC.self))
        guard let grpsTVC = sb.instantiateViewController(withIdentifier: "SettingsTVCID") as? SettingsTVC else {
            print("⛔️ Error getting SettingsTVCID from storyboard")
            return SettingsTVC()
        }
        return grpsTVC
    }
    
    deinit {
        print("SettingsTVC deinited")
    }


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        
        // Remove Search bar
        self.searchController.searchBar.isHidden = true
        self.navigationItem.searchController = nil
        
        self.sect.append(Segment(title: "Security", cells:[
            Cell(title: "Password Protection", type: .passwordEnable, action: nil),
            Cell(title: "Touch/Face ID", type: .touchFaceID, action: nil),
            Cell(title: "Change Password", type: .passwordChange, action: {
                print("🙀 ACTION : Change Password")
                self.changeSettingsPassword()
            })
        ] ))
        self.sect.append(Segment(title: "Export", cells:[
            Cell(title: "Export Passwords", type: .exportPassword, action: {
                print("🙀 ACTION : Export Passwords")
                self.copyCacheFileIntoDocumentsDir()
            })
        ] ))
    }
    
    // MARK: - Actions
    
    func copyCacheFileIntoDocumentsDir() {
        let fileManager = FileManager.default

        let appSupportFolderPath = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first! as NSURL
        guard let srcPath = appSupportFolderPath.appendingPathComponent("p.realm") else {
            Log.error("⛔️Unable to get Realm path")
            return
        }
        
        let documentsFolderPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        guard let destPath = documentsFolderPath.appendingPathComponent("supercache") else {
            Log.error("⛔️ Unable to get documentsFolderPath path")
            return
        }

        
        do {
            if !FileManager.default.fileExists(atPath: srcPath.path) {
                Log.error("⛔️ Realm File doesn't exists")
                return
            }
            try FileManager.default.copyItem(at: srcPath, to: destPath)
        } catch (let error) {
            Log.error("Cannot copy item at \(srcPath) to \(destPath): \(error)")
            return
        }
    }

    
    
    func changeSettingsPassword() {
        
        DataManager.shared.cacheGetSettingsPassword { [weak self] setPass in
            if let sp = setPass, let s = self {
                s.showSettingsPasswordEditAlert(title: "Changing Password", message: "Please enter your current password", currentPassword: sp.userPassword) { match, error in
                    if match && error == nil {
                        
                        // Edit current
                        let setPassCreateVC = SettingsCreateEditPasswordVC.initFromStoryboard(settingsPassword: sp, delegate: s)
                        let pcNC = UINavigationController(rootViewController: setPassCreateVC)
                        s.present(pcNC, animated: true) {
                            s.refreshTableView(animated: false)
                        }
                        
                    } else if let e=error {
                        s.showAlert(title: e, message: "") {
                            s.refreshTableView(animated: true)
                        }
                    }
                }
            } else {
                Log.error("⛔️ Error getting settings password")
            }
        }
        
    }
    
    // MARK: - Helpers
    
    func showSettingsPasswordEditAlert(title: String, message: String, currentPassword: String, completion: @escaping (_ match: Bool, _ error: String?) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Password"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak self] action in
            self?.refreshTableView(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak alert] (_) in
        if let al = alert, let tfs = al.textFields, let tf = tfs.first {
            if tf.text == currentPassword {
                completion(true, nil)
            } else {
                completion(false, "Wrong password")
            }
        } else {
            completion(false, "Internal error")
        }
        }))
        self.present(alert, animated: true, completion: nil)
    }

    
}
