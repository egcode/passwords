//
//  LoginCell.swift
//  Passwords
//
//  Created by Eugene G on 9/17/21.
//

import UIKit


class LoginCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    
    private var top = false
    private var bottom = false
    public static let cellHeight:CGFloat = 64
    public static let widthMargin:CGFloat = 32
    public static let cellBorderRadius:CGFloat = 20

    private var imageAlpha:CGFloat = 0.5
    
    @IBOutlet weak var securityImageView: UIImageView!
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // contentViewMargined changes it's margin in parralell with roundCell function.
        self.roundCell(top: self.top, bottom: self.bottom)
      }
    
    func configureCell(user: User, top:Bool, bottom:Bool) {
        self.labelTitle.text = user.name
        
        self.top = top
        self.bottom = bottom
        
        if let settingsPass = user.settingsPassword {
            if settingsPass.useTouchFaceID {
                self.securityImageView.alpha = self.imageAlpha
                self.securityImageView.image = UIImage(named: "fingerprint")
            } else {
                self.securityImageView.alpha = self.imageAlpha
                self.securityImageView.image = UIImage(named: "password")
            }
        } else {
            self.securityImageView.image = nil
            self.securityImageView.alpha = 0.0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.securityImageView.image = nil
        self.securityImageView.alpha = 0.0
    }
    
    
    // MARK: - Round cell
    
    func roundCell(top:Bool, bottom:Bool) {
        let shape = CAShapeLayer()
        var corners: UIRectCorner =  []
        let rect = CGRect(x: LoginCell.widthMargin/2, y: 0, width: bounds.width-LoginCell.widthMargin, height: bounds.size.height)

        if self.top == false && self.bottom == false {
            shape.path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: LoginCell.cellBorderRadius, height: LoginCell.cellBorderRadius)).cgPath
        } else {
            layer.mask = nil // reset mask
            
            corners = self.top ? [.topLeft, .topRight] : [.bottomRight, .bottomLeft]
            if self.top && self.bottom {
                corners = [.topLeft, .topRight, .bottomRight, .bottomLeft]
            }

            shape.path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: LoginCell.cellBorderRadius, height: LoginCell.cellBorderRadius)).cgPath

        }
        layer.mask = shape
        layer.masksToBounds = true
    }

    
}
