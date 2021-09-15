//
//  UINavigationController+Completion.swift
//  Passwords
//
//  Created by Eugene G on 9/14/21.
//

import UIKit

extension UINavigationController {
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        self.pushViewController(viewController, animated: animated)
        self.callCompletion(animated: animated, completion: completion)
    }

    func popViewController(animated: Bool, completion: @escaping () -> Void) -> UIViewController? {
        let viewController = self.popViewController(animated: animated)
        self.callCompletion(animated: animated, completion: completion)
        return viewController
    }

    private func callCompletion(animated: Bool, completion: @escaping () -> Void) {
        if animated, let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
}
