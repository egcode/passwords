//
//  PasswordViewVC.swift
//  Passwords
//
//  Created by Eugene G on 9/13/21.
//

import UIKit

class PasswordViewVC : UIViewController {

    private var passwordViewModel: PasswordViewModel!
    
    @IBOutlet weak var labelUserID: UILabel!
    @IBOutlet weak var labelPassword: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var buttonEdit: UIButton!
    
    
    // MARK: - init/deinit
    
    public static func initFromStoryboard(passwordViewModel: PasswordViewModel) -> PasswordViewVC {
        let sb = UIStoryboard(name: "RootVC", bundle: Bundle(for: PasswordViewVC.self))
        guard let passwordViewVC = sb.instantiateViewController(withIdentifier: "PasswordViewVCID") as? PasswordViewVC else {
            print("⛔️ Error getting PasswordViewVC from storyboard")
            return PasswordViewVC()
        }
        passwordViewVC.passwordViewModel = passwordViewModel
        return passwordViewVC
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        Log.error("PasswordViewVC inited without storyboard. It should not happen")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Log.debug("PasswordViewVC inited")
    }

    deinit {
        print("PasswordViewVC deinited")
    }

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.passwordViewModel.title
        self.labelUserID.text = self.passwordViewModel.userID
        self.labelPassword.text = self.passwordViewModel.pass
        self.textViewDescription.text = self.passwordViewModel.desc
    }
    
    
    // MARK: - Actions
    
    @IBAction func actionButtonEdit(_ sender: UIButton) {
        print("Sel: \(String(describing: self.passwordViewModel))")
    }
    
    
    
}
