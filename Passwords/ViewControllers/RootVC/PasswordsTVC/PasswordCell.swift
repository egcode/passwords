//
//  PasswordCell.swift
//  Passwords
//
//  Created by Eugene G on 9/9/21.
//

import UIKit


class PasswordCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    var passwordViewModel: PasswordViewModel! {
        didSet {
            self.labelTitle.text = self.passwordViewModel.title
            self.labelDescription.text = self.passwordViewModel.desc
        }
    }
    
    
    override class func awakeFromNib() {
        //Configure ui look
    }
    
}
