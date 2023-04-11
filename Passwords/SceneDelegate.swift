//
//  SceneDelegate.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coverView: UIView?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Create the cover view
        coverView = UIView(frame: window?.bounds ?? UIScreen.main.bounds)
        coverView?.backgroundColor = Colors.mainColor
        
        // Create the UIImageView with the "lock" system image
        let lockImageView = UIImageView(image: UIImage(systemName: "lock"))
        lockImageView.tintColor = .white
        lockImageView.contentMode = .scaleAspectFit
        lockImageView.translatesAutoresizingMaskIntoConstraints = false

        // Add the lock image view to the cover view
        if let coverView = coverView {
            coverView.addSubview(lockImageView)
            
            // Center the lock image view within the cover view
            NSLayoutConstraint.activate([
                lockImageView.centerXAnchor.constraint(equalTo: coverView.centerXAnchor),
                lockImageView.centerYAnchor.constraint(equalTo: coverView.centerYAnchor),
                lockImageView.widthAnchor.constraint(equalToConstant: 100),
                lockImageView.heightAnchor.constraint(equalToConstant: 100)
            ])
            
            // Add the cover view to the application's window
            window?.addSubview(coverView)
        }
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Remove the cover view from the application's window
        coverView?.removeFromSuperview()
        coverView = nil
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

