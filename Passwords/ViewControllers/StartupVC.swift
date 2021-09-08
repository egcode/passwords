//
//  StartupVC.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import UIKit

class StartupVC: UIViewController {

    public static var isLoggedIn:Bool {
        return StartupVC._isLoggedIn
    }
    fileprivate static var _isLoggedIn = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Orientation portrait only
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        StartupVC.showLogin(title: "Title Blah", message: "message blah")
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        UILoadingView.showGlobal(withText: "aa")
    }
        
    // MARK: - Transition states
    
    public class func showLogin(title: String?, message: String?) {
        let sb = UIStoryboard(name: "LoginVC", bundle: nil)
        StartupVC.animateTransition(sb, addNavigationBar: true) { (vc) in
            StartupVC._isLoggedIn = false
            if let t = title, let m = message {
//                vc.showAlert(title: t, message: m) {
//                    //
//                }
            } else {
                print("showLogin title and message are nil. showLogin without alert")
            }
        }
    }

    public class func showRootVC() {
        let sb = UIStoryboard(name: "RootVC", bundle: nil)
        StartupVC.animateTransition(sb, addNavigationBar: false) { (vc) in
            StartupVC._isLoggedIn = true
        }
    }
    
    private class func animateTransition(_ storyboard:UIStoryboard, addNavigationBar:Bool, animCompletion: @escaping ((UIViewController)->Void)) {
        GCD.mainThread {
//            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//                return
//            }
            guard var vc = storyboard.instantiateInitialViewController() else {
                return
            }
            vc = addNavigationBar ? UINavigationController(rootViewController: vc) : vc
            
            // Scene Delegate
            let win = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!
            let snapshot:UIView = win!.snapshotView(afterScreenUpdates: true)!
            
//            let snapshot:UIView = (appDelegate.window?.snapshotView(afterScreenUpdates: true))!
            vc.view.addSubview(snapshot);
            
//            appDelegate.window?.rootViewController = vc// asign
            win?.rootViewController = vc // assign
            
            UIView.animate(withDuration: 0.3, animations: {() in
                snapshot.layer.opacity = 0;
                snapshot.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.1);
            }, completion: {
                (value: Bool) in
                snapshot.removeFromSuperview();
                animCompletion(vc)
            });
        }
    }

}
