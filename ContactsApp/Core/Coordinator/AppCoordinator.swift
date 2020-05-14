//
//  AppCoordinator.swift
//  ContactsApp
//
//  Created by maxim mironov on 01.05.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import UIKit
class AppCoordinator {
    var coordinator: Coordinator!
    var router:Router!

    init(window:UIWindow) {
         self.router = Router(navigationController: window.rootViewController?.navigationController ?? UINavigationController())
    }
    
    func next(coordinator: AppCoordinatorEnum) {
        let vc = getCoordinator(coordinator: coordinator)
        self.router.next(viewController: vc)
    }
    
    fileprivate func getCoordinator(coordinator: AppCoordinatorEnum) -> UIViewController {
        var nextCoordinator : BaseCoordinator!
        self.router.navigationController.navigationBar.isHidden = false
        switch coordinator {
            case .login(let coordinator):
                let qnextCoordinator = LoginCoordinator(appCoordinator: self).start()
                if let coordinator = coordinator{
                    qnextCoordinator.complete  = { [unowned self] in
                        self.router.navigationController.viewControllers = [self.getCoordinator(coordinator: coordinator)]
                    }
                    self.router.navigationController.navigationBar.isHidden = true
                    return qnextCoordinator
                }
            case .contcts:
                nextCoordinator = ContactsCoordinator(appCoordinator: self)
            case .details(contact: let contact):
                nextCoordinator = ContactDetailsCoordinator(contact: contact, app: self)
        }
        return nextCoordinator.start()
    }
}
