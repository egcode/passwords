//
//  Colors.swift
//  Passwords
//
//  Created by Eugene G on 9/9/21.
//

import UIKit

@objcMembers public class Colors : UIColor {
    
    // Text Color
    public static let textDarkGrey = UIColor(red: 66.0/255.0, green: 66.0/255.0, blue: 66.0/255.0, alpha: 1.0)
    public static let textLightGrey = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1.0)
    public static let textWhite = UIColor.white
    public static let textTransparentBG = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
    public static let alertButtonTextColor = UIColor(red: 0.0, green: 181.0/255.0, blue: 226.0/255.0, alpha: 1.0)
    public static let multiOrgCellTextColor = UIColor(named: "#424242")
    
    // Global
    public static let windowColor = UIColor.white

    // Navigation Bar
    public static let navBGColor = UIColor.white
    public static let navTitleColor = textDarkGrey
    public static let navTintColor = UIColor.darkText

    public static let navBottomColor = UIColor(red: 93.0/255.0, green: 145.0/255.0, blue: 195.0/255.0, alpha: 1.0)
    public static let navTopColor = UIColor(red: 24.0/255.0, green: 46.0/255.0, blue: 72.0/255.0, alpha: 1.0)
    
    
    
    // Table View
    public static let selectedTableViewCell = UIColor(red: 238.0/255.0, green: 238.0/255.0, blue: 238.0/255.0, alpha: 1.0)
    public static let cellGradientStartColor = UIColor(named: "#001116")
    public static let emptyStateText = UIColor(named: "#001116")

    public static let tvcBGColor = UIColor.white

    // Cell
    public static let cellOfflineBG = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
    public static let cellLiveBG = UIColor(red: 1.0, green: 0.2, blue: 0.14, alpha: 1.0)
    public static let cellPlaybackBG = UIColor(red: 0.0, green: 0.07, blue: 0.09, alpha: 1.0)

    // Tabbar
    public static let tabbarSelectedTabTint = UIColor(red: 0.0, green: 0.49, blue: 0.62, alpha: 1.0)
    public static let tabbarOrgContentViewBG = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    public static let tabbarOrgTextColor = UIColor(named: "#4A4A4A")

    // Connection banner
    public static let bannerBG = UIColor(red: 255.0/255.0, green: 225.0/255.0, blue: 222.0/255.0, alpha: 1.0)
    public static let bannerTextColor =  UIColor(red: 1.0, green: 0.2, blue: 0.14, alpha: 1.0)

    // Recent Cell paginationControl
    public static let paginationControlLight =  UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
    public static let paginationControlSelected =  UIColor(red: 0.0, green: 0.71, blue: 0.89, alpha: 1.0)

    // Playback
    public static let playbackControllsBG =  UIColor(red: 0.0, green: 0.07, blue: 0.09, alpha: 0.5)
    public static let playbackGoToLiveBG =  UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1.0)
    
    // Popup views
    public static let dimmedBG =  UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
    public static let pickerBG =  UIColor.white

}

