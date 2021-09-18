//
//  LoginCell.swift
//  Passwords
//
//  Created by Eugene G on 9/17/21.
//

import UIKit


class LoginCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    
    func configureCell(user: User) {
        self.labelTitle.text = user.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
