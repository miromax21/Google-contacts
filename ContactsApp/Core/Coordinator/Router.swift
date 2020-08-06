//
//  Router.swift
//  ContactsApp
//
//  Created by maxim mironov on 14.05.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

import Foundation
import UIKit

indirect enum AppCoordinatorEnum{
    case login(coordinator: AppCoordinatorEnum? = nil)
    case contcts
    case details(contact:Entry?)
}

class Router {
    
    var navigationController : UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    func next(viewController:UIViewController)  {
        self.navigationController.pushViewController(viewController, animated: true)
    }
    

}
