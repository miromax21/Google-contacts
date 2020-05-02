//
//  AuthenticationModule.swift
//  ContactsApp
//
//  Created by maxim mironov on 14.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//

class LoginCoordinator:BaseCoordinator {
    
    override func start() {
        let loginViewController = LoginViewController()
        let p = LoginViewModel()
        loginViewController.presentor = p
        self.navigationController.viewControllers = [loginViewController]
    }
}


