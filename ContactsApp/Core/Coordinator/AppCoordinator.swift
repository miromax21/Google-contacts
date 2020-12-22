//
//  AppCoordinator.swift
//  ContactsApp
//
//  Created by maxim mironov on 01.05.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import UIKit
final class AppCoordinator {
    
    var coordinator: Coordinator!
    var router: Router!

    init(window:UIWindow) {
         self.router = Router(navigationController: window.rootViewController?.navigationController ?? UINavigationController())
    }
    
    func next(coordinator: AppCoordinatorEnum) {
        let vc = getCoordinator(coordinator: coordinator)
        self.router.next(viewController: vc)
    }
    
    fileprivate func getCoordinator(coordinator: AppCoordinatorEnum) -> UIViewController {
        self.router.navigationController.navigationBar.isHidden = false
        switch coordinator {
            case .login(let coordinator):
                return presentViewController(coordinator: LoginCoordinator(), goAfterCoordinator: coordinator)
            case .contcts:
                return presentViewController(coordinator: ContactsCoordinator())
            case .details(contact: let contact):
                return presentViewController(coordinator: ContactDetailsCoordinator(contact: contact))
        }
        
    }
    
    fileprivate func presentViewController(coordinator : BaseCoordinator) -> UIViewController {
         coordinator.appCoordinator = self
         return coordinator.start()
    }
    
    fileprivate func presentViewController(coordinator : BaseCoordinator, goAfterCoordinator : AppCoordinatorEnum?) -> UIViewController {
        
        let nextController = coordinator.start()
        
        guard let nextPresentableController = nextController as? PresentableViewController, let goAfter = goAfterCoordinator else {
             return presentViewController(coordinator: coordinator)
        }
        
        coordinator.appCoordinator = self
        self.router.navigationController.navigationBar.isHidden = true
        
        nextPresentableController.complete = {
            self.router.navigationController.viewControllers = [self.getCoordinator(coordinator: goAfter)]
        }

        return nextPresentableController
        
    }
}
