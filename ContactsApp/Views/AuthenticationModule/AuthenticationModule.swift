//
//  AuthenticationModule.swift
//  ContactsApp
//
//  Created by maxim mironov on 14.04.2020.
//  Copyright © 2020 maxim mironov. All rights reserved.
//
import UIKit
class LoginCoordinator:BaseCoordinator {
    
    override func start() -> LoginViewController {
        let loginVM =  LoginViewModel(coordinator: self)
        //super.start(coordinator: self)
        return loginVM.Output
    }
}


