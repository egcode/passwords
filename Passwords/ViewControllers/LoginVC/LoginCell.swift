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
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
