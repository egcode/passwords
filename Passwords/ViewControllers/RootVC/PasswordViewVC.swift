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
    
    @IBOutlet weak var labelLabelUserID: UILabel!
    @IBOutlet weak var labelLabelPassword: UILabel!
    @IBOutlet weak var labelTextViewDescription: UILabel!
    
    weak var delegate: PasswordsTVCRefreshProtocol?
    
    // MARK: - init/deinit
    
    public static func initFromStoryboard(passwordViewModel: PasswordViewModel) -> PasswordViewVC {
        let sb = UIStoryboard(name: "RootVC", bundle: Bundle(for: PasswordViewVC.self))
        guard let passwordViewVC = sb.instantiateViewController(withIdentifier: "PasswordViewVCID") as? PasswordViewVC else {
            Log.debug("⛔️ Error getting PasswordViewVC from storyboard")
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
        Log.debug("PasswordViewVC deinited")
    }

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapPass = UITapGestureRecognizer(target: self, action: #selector(self.tapOnPassword(_:)))
        self.labelPassword.addGestureRecognizer(tapPass)
        self.labelPassword.isUserInteractionEnabled = true
        self.initBindUI()
    }
    
    // MARK: - Bind UI
    
    func initBindUI() {
        self.passwordViewModel.titleModel.bind { [weak self] title in
            if let s = self {
                s.title=title
                s.navigationController?.title = title
            }
        }
        self.passwordViewModel.userIDModel.bind { [weak self] userID in
            if let s = self {
                s.labelUserID.text = userID
                if userID == "" {
                    s.labelUserID.isHidden = true
                    s.labelUserID.gestureRecognizers?.removeAll()
                    s.labelLabelUserID.isHidden = true
                } else {
                    s.labelUserID.isHidden = false
                    s.labelLabelUserID.isHidden = false
                    let tapUser = UITapGestureRecognizer(target: s, action: #selector(s.tapOnUserID(_:)))
                    s.labelUserID.addGestureRecognizer(tapUser)
                    s.labelUserID.isUserInteractionEnabled = true
                }
            }
        }
        self.passwordViewModel.passModel.bind { [weak self] passwrd in
            self?.labelPassword.text = passwrd
        }
        self.passwordViewModel.descModel.bind { [weak self] dsc in
            if let s = self {
                if dsc == "" {
                    s.labelTextViewDescription.isHidden = true
                } else {
                    s.labelTextViewDescription.isHidden = false
                }
            }
            self?.textViewDescription.text = dsc
        }
    }

    
    // MARK: - Actions
    
    @IBAction func actionButtonEdit(_ sender: UIButton) {
        Log.debug("Sel: \(String(describing: self.passwordViewModel))")
        let passCreateVC = PasswordCreateEditVC.initFromStoryboard()
        passCreateVC.passwordViewModel = self.passwordViewModel
        passCreateVC.action = { [unowned self] in
            self.delegate?.putToTop(passwordVM: self.passwordViewModel)
        }
        self.navigationController?.pushViewController(passCreateVC, animated: true)
    }
    
    @objc func tapOnUserID(_ sender: UITapGestureRecognizer) {
        //labelUserID
        Log.debug("tapOnUserID")
        UIPasteboard.general.string = self.labelUserID.text
        self.animateLabel(label: self.labelUserID)
      }

    @objc func tapOnPassword(_ sender: UITapGestureRecognizer) {
        Log.debug("tapOnPassword")
        UIPasteboard.general.string = self.labelPassword.text
        self.animateLabel(label: self.labelPassword)
      }
    
    
    fileprivate func animateLabel(label:UILabel) {
        let font = label.font
        let text = label.text
        let textColor = label.textColor
        let bgColor = label.backgroundColor
        
        UIView.transition(with: label, duration: 0.1, options: .transitionCrossDissolve) {
            
            label.font = Fonts.latoBold(size: 20)
            label.text = "Copied"
            label.textColor = Colors.orange
            label.backgroundColor = Colors.systemRed
            
        } completion: { success in
            
            GCD.mainThreadDelayed(delay: 0.6) { [weak self] in
                UIView.transition(with: label, duration: 0.3, options: .transitionCrossDissolve) {
                    if let _ = self {
                        label.font = font
                        label.text = text
                        label.textColor = textColor
                        label.backgroundColor = bgColor
                    }
                } completion: { success in
                }
            }

        }

        
        
    }

}
