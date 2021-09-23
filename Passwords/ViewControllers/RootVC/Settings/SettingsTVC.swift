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
        case importPassword
        case exit
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
    
    init() {
        super.init(nibName: nil, bundle: nil)
        Log.error("SettingsTVC inited without storyboard. It should not happen")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Log.debug("SettingsTVC inited")
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(didBecomeActive),
//                                               name: UIApplication.didBecomeActiveNotification,
//                                               object: nil)
    }
    
    deinit {
//        NotificationCenter.default.removeObserver(self)
        print("SettingsTVC deinited")
    }


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        self.applyLargeTitles()
        self.applyGlobalNavbarBlueColor()
        
        self.sect.append(Segment(title: "Security", cells:[
            Cell(title: "Password Protection", type: .passwordEnable, action: nil),
            Cell(title: "Touch/Face ID", type: .touchFaceID, action: nil),
            Cell(title: "Change Password", type: .passwordChange, action: { [unowned self] in
                Log.debug("🙀 ACTION : Change Password")
                self.changeSettingsPassword()
            })
        ] ))
        self.sect.append(Segment(title: "Export", cells:[
            Cell(title: "Export Passwords", type: .exportPassword, action: { [unowned self] in
                Log.debug("🙀 ACTION : Export Passwords")
                self.copyCacheFileIntoDocumentsDir()
            }),
            Cell(title: "Import Passwords", type: .importPassword, action: { [unowned self] in
                Log.debug("🙀 ACTION : Import Passwords")
                self.copyCacheFileIntoApplicationSupportDir()
            }),
            Cell(title: "Exit", type: .exportPassword, action: { [unowned self] in
                Log.debug("🙀 Exit")
                self.exit()
            })
        ] ))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkForTTL()
    }
    
//    @objc func didBecomeActive() {
//        self.checkForTTL()
//    }

    // MARK: - Trait Collection. Dark/Light modes change

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.applyGlobalNavbarBlueColor()
    }

    // MARK: - Actions
    
    func copyCacheFileIntoDocumentsDir() {
        
        var isBiometricNeeded = true
        #if targetEnvironment(simulator)
        isBiometricNeeded = false
        #else
        #endif
        if Passcode.isDevicePasscodeSet() && isBiometricNeeded {
            Passcode.authenticateUser(message: "Please authenticate to proceed") { (success, error) in
                if success && error == nil {
                    self.processCopyCacheFileIntoDocumentsDir(isBackup: false) { error in
                        if let e = error {
                            self.showAlert(title: "Error", message: e)
                        } else {
                            self.showAlert(title: "Success copy to documents folder", message: "")
                        }
                    }
                } else {
                    if let e = error {
                        self.showAlert(title: "Error", message: e.localizedDescription)
                    } else {
                        self.showAlert(title: "Error", message: "Something went wrong")
                    }
                }
            }
        } else {
            self.processCopyCacheFileIntoDocumentsDir(isBackup: false) { error in
                if let e = error {
                    self.showAlert(title: "Error", message: e)
                } else {
                    self.showAlert(title: "Success copy to documents folder", message: "")
                }
            }
        }
    }
    
    func copyCacheFileIntoApplicationSupportDir() {
        
        var isBiometricNeeded = true
        #if targetEnvironment(simulator)
        isBiometricNeeded = false
        #else
        #endif
        if Passcode.isDevicePasscodeSet() && isBiometricNeeded {
            Passcode.authenticateUser(message: "Please authenticate to proceed") { (success, error) in
                if success && error == nil {
                    self.processCopyCacheFileIntoDocumentsDir(isBackup: false) { error in
                        if let e = error {
                            self.showAlert(title: "Error", message: e)
                        } else {
//                            self.showAlert(title: "Success copy (backup) to documents folder", message: "")
                            
                            self.processCopyCacheFileIntoApplicationSupportDir { error in
                                if let e = error {
                                    self.showAlert(title: "Error", message: e)
                                } else {
                                    self.showAlert(title: "Backup restore success", message: "Restarting the app") {
                                        fatalError()
                                    }
                                }
                            }
                            
                            
                        }
                    }

                } else {
                    if let e = error {
                        self.showAlert(title: "Error", message: e.localizedDescription)
                    } else {
                        self.showAlert(title: "Error", message: "Something went wrong")
                    }
                }
            }
        } else {
            
            self.processCopyCacheFileIntoDocumentsDir(isBackup: false) { error in
                if let e = error {
                    self.showAlert(title: "Error", message: e)
                } else {
//                            self.showAlert(title: "Success copy (backup) to documents folder", message: "")
                    
                    self.processCopyCacheFileIntoApplicationSupportDir { error in
                        if let e = error {
                            self.showAlert(title: "Error", message: e)
                        } else {
                            self.showAlert(title: "Backup restore success", message: "Restarting the app") {
                                fatalError()
                            }
                        }
                    }
                    
                    
                }
            }
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
    
    func exit() {
        StartupVC.showLogin(title: nil, message: nil)
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

    // MARK: - File management

    func processCopyCacheFileIntoDocumentsDir(isBackup:Bool, completion: @escaping ((_ error: String?) -> Void) ) {
        Log.debug("Method processCopyCacheFileIntoDocumentsDir")
        
        let fileManager = FileManager.default
        let appSupportFolderPath = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first! as NSURL
        guard let srcPath = appSupportFolderPath.appendingPathComponent(Constants.CacheNaming.cacheFileName) else {
            completion("⛔️Unable to get Realm path")
            return
        }
        let documentsFolderPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        
        
        #if DEBUG
        var fileName = Constants.CacheNaming.cacheDebugCopyFilename
        #else
        guard let k = DataManager.shared.keychainReadCacheKey() else {
            completion("⛔️ Unable to get key")
            return
        }
        var fileName = k
        #endif
        
        if isBackup {
            fileName = "(backup)\(fileName)"
        }
        guard let destPath = documentsFolderPath.appendingPathComponent(fileName) else {
            completion("⛔️ Unable to get documentsFolderPath path")
            return
        }
        
//        self.copyFile(srcPath: srcPath, destPath: destPath, operation: "copy to documents ")
        self.copyFile(srcPath: srcPath, destPath: destPath, operation: "copy to documents") { error in
            if let e = error {
                completion(e)
            } else {
                completion(nil)
            }
        }

    }
    
    func processCopyCacheFileIntoApplicationSupportDir(completion: @escaping ((_ error: String?) -> Void) ) {
        Log.debug("Method processCopyCacheFileIntoApplicationSupportDir")

        let fileManager = FileManager.default
        let documentsFolderPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        #if DEBUG
        let fileName = Constants.CacheNaming.cacheDebugCopyFilename
        #else
        guard let fileName = DataManager.shared.keychainReadCacheKey() else {
            completion("⛔️ Unable to get key")
            return
        }
        #endif
        guard let srcPath = documentsFolderPath.appendingPathComponent(fileName) else {
            completion("⛔️Unable to get Realm path in documents")
            return
        }
        
        let appSupportFolderPath = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first! as NSURL
        guard let destPath = appSupportFolderPath.appendingPathComponent(fileName) else {
            completion("⛔️ Unable to get appSupportFolderPath path")
            return
        }

//        self.copyFile(srcPath: srcPath, destPath: destPath, operation: "copy to application support ")
        self.copyFile(srcPath: srcPath, destPath: destPath, operation: "copy to application support") { error in
            if let e = error {
                completion(e)
            } else {
                completion(nil)
            }
        }
    }
    
    func copyFile(srcPath: URL, destPath: URL, operation: String, completion: @escaping ((_ error: String?) -> Void) ) {
        do {
            if !FileManager.default.fileExists(atPath: srcPath.path) {
//                Log.error("⛔️ Realm File doesn't exists")
                completion("Failure \(operation)\nFile at \(srcPath.path) doesn't exist")
                return
            }
            if FileManager.default.fileExists(atPath: destPath.path) {
                try FileManager.default.removeItem(at: destPath)
            }
            try FileManager.default.copyItem(at: srcPath, to: destPath)
            completion(nil)
//            self.showAlert(title: "Success \(operation)", message: "")
        } catch (let error) {
//            Log.error("Cannot copy item at \(srcPath) to \(destPath): \(error)")
            completion("Failure \(operation), copy from \(srcPath) to \(destPath): \(error)\n\(error.localizedDescription)")
//            self.showAlert(title: "Failure \(operation), copy from \(srcPath) to \(destPath): \(error)", message: error.localizedDescription)
            return
        }
    }

    
}
