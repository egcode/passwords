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
            })
        ] ))
        self.sect.append(Segment(title: "Export", cells:[
            Cell(title: "Export Passwords", type: .exportPassword, action: {
                print("🙀 ACTION : Export Passwords")
            })
        ] ))
    }
    
}
