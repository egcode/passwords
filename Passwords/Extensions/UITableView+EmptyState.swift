//
//  UITableView+EmptyState.swift
//  Passwords
//
//  Created by Eugene G on 9/9/21.
//

import UIKit

public extension UITableView {
    
    func setEmptyState(_ title: String, _ message: String) {
        
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let titleHeight: CGFloat = 40
        let messageHeight: CGFloat = 70
        let margin: CGFloat = 20
        
        // Title label on the Center
        let titleLabel = UILabel(frame: CGRect(x: margin, y:(self.bounds.size.height/2)-(titleHeight/2) , width: self.bounds.size.width-(margin*2), height: titleHeight))
        titleLabel.text = title
        titleLabel.textColor = Colors.darkGray
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = .center;
        titleLabel.font = Fonts.latoRegular(size: 32)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.3
        emptyView.addSubview(titleLabel)
        
        let messageLabel = UILabel(frame: CGRect(x: margin, y: (self.bounds.size.height/2)+(titleHeight/2), width: self.bounds.size.width-(margin*2), height: messageHeight))
        messageLabel.text = message
        messageLabel.textColor = Colors.lightGray
        messageLabel.numberOfLines = 3;
        messageLabel.textAlignment = .center;
        messageLabel.font = Fonts.latoLight(size: 16)
        messageLabel.adjustsFontSizeToFitWidth = true
        messageLabel.minimumScaleFactor = 0.3
        emptyView.addSubview(messageLabel)
        
        self.backgroundView = emptyView;
        self.separatorStyle = .none;
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
